package com.kh.burgerstack.inventory.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.exception.BusinessException;
import com.kh.burgerstack.inventory.dao.InventoryTransactionDao;
import com.kh.burgerstack.inventory.dto.InventoryChangeParam;
import com.kh.burgerstack.inventory.dto.InventoryTransactionCreateCommand;
import com.kh.burgerstack.inventory.dto.InventoryTransactionDetail;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListItem;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListView;
import com.kh.burgerstack.inventory.dto.InventoryTransactionSearchCondition;
import com.kh.burgerstack.inventory.vo.InventoryTransaction;
import com.kh.burgerstack.inventory.vo.InventoryTransactionItem;
import com.kh.burgerstack.store.StoreDao;
import com.kh.burgerstack.store.dto.StoreOption;
import com.kh.burgerstack.user.LoginUser;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InventoryTransactionService {

    private final InventoryTransactionDao inventoryTransactionDao;
    private final StoreDao storeDao;

    /**
     * @param command
     * @return
     */
    @Transactional
    protected InventoryTransaction createTransaction(InventoryTransactionCreateCommand command) {
        InventoryTransaction inventoryTransaction = new InventoryTransaction(
                null,
                command.getTransactionType(),
                command.getReason(),
                command.getTransactionMemo(),
                null,
                command.getCreatedBy(),
                command.getStoreId(),
                command.getReceiptId(),
                command.getStoreClosingId());

        inventoryTransactionDao.insert(inventoryTransaction);

        List<InventoryTransactionItem> items = command.getInventoryTransactionItems()
                .stream()
                .map((InventoryChangeParam param) -> new InventoryTransactionItem(
                        param.getBeforeQuantity(),
                        param.getAfterQuantity(),
                        param.getInventoryId()))
                .toList();

        for (InventoryTransactionItem item : items) {
            inventoryTransactionDao.insertItem(
                    inventoryTransaction.getInventoryTransactionId(),
                    item);
        }

        return inventoryTransaction;

    }

    public InventoryTransactionListView getInventoryTransactionListView(
            InventoryTransactionSearchCondition condition,
            PagingRequest pagingRequest,
            LoginUser loginUser) {
        if (loginUser.isOwner()) {
            condition.setStoreId(loginUser.getStoreId().intValue());
        }

        if (!loginUser.isAdmin() && condition.getStoreId() != null
                && condition.getStoreId() != loginUser.getStoreId().intValue()) {
            throw new BusinessException("재고를 찾을 수 없습니다.");
        }

        List<InventoryTransactionListItem> list = inventoryTransactionDao.findInventoryTransactionListItems(
                condition,
                pagingRequest,
                loginUser);
        int totalCount = inventoryTransactionDao.count(condition);
        List<StoreOption> storeOptions = storeDao.getStoreOptions();

        return new InventoryTransactionListView(
                list,
                storeOptions,
                condition,
                pagingRequest.toPageInfo(totalCount));
    }

    public InventoryTransactionDetail getInventoryTransactionDetail(
            int inventoryTransactionId,
            LoginUser loginUser) {
        InventoryTransactionDetail detail = inventoryTransactionDao
                .getInventoryTransactionDetailById(inventoryTransactionId);
        if (!loginUser.isAdmin() && detail.getStoreId() != null
                && detail.getStoreId() != loginUser.getStoreId().intValue()) {
            throw new BusinessException("재고 변동 이력을 찾을 수 없습니다.");
        }
        detail.setList(inventoryTransactionDao.findInventoryTransactionDetailItems(inventoryTransactionId));

        return detail;
    }

}

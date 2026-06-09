package com.kh.burgerstack.inventory.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.exception.CustomException;
import com.kh.burgerstack.inventory.dao.InventoryTransactionDao;
import com.kh.burgerstack.inventory.dto.InventoryTransactionCreateCommand;
import com.kh.burgerstack.inventory.dto.InventoryTransactionDetail;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListItem;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListView;
import com.kh.burgerstack.inventory.dto.InventoryTransactionSearchCondition;
import com.kh.burgerstack.inventory.vo.InventoryTransaction;
import com.kh.burgerstack.user.LoginUser;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InventoryTransactionService {
    private final InventoryTransactionDao inventoryTransactionDao;
    private static final List<String> TRANSACTION_TYPE = List.of("RECEIPT", "STORE_CLOSING", "ADJUSTMENT");

    @Transactional
    public InventoryTransaction createTransaction(InventoryTransactionCreateCommand command) {
        if (!TRANSACTION_TYPE.contains(command.getTransactionType())) {
            throw new CustomException("재고 변동 이력 유형이 올바르지 않습니다.");
        }

        InventoryTransaction inventoryTransaction = command.getInventoryTransaction();
        inventoryTransactionDao.insert(inventoryTransaction);

        inventoryTransactionDao.insertItems(
                inventoryTransaction.getInventoryTransactionId(),
                command.getInventoryTransactionItems());

        return inventoryTransaction;
    }

    public InventoryTransactionListView getInventoryTransactionListView(
            InventoryTransactionSearchCondition condition,
            PagingRequest pagingRequest,
            LoginUser loginUser) {
        if (!loginUser.isAdmin() && condition.getStoreId() != null
                && condition.getStoreId() != loginUser.getStoreId().intValue()) {
            throw new CustomException("재고를 찾을 수 없습니다.");
        }

        List<InventoryTransactionListItem> list = inventoryTransactionDao.findInventoryTransactionListItems(
                condition,
                pagingRequest,
                loginUser);
        int totalCount = inventoryTransactionDao.count(condition);

        return new InventoryTransactionListView(list, pagingRequest.toPageInfo(totalCount));
    }

    public InventoryTransactionDetail getInventoryTransactionDetail(
            int inventoryTransactionId,
            LoginUser loginUser) {
        InventoryTransactionDetail detail = inventoryTransactionDao
                .getInventoryTransactionDetailById(inventoryTransactionId);
        if (!loginUser.isAdmin() && detail.getStoreId() != null
                && detail.getStoreId() != loginUser.getStoreId().intValue()) {
            throw new CustomException("재고 변동 이력을 찾을 수 없습니다.");
        }
        detail.setList(inventoryTransactionDao.findInventoryTransactionDetailItems(inventoryTransactionId));

        return detail;
    }

}

package com.kh.burgerstack.inventory.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.exception.BusinessException;
import com.kh.burgerstack.exception.NotFoundException;
import com.kh.burgerstack.inventory.command.ChangeInventoryByAdjustmentCommand;
import com.kh.burgerstack.inventory.command.ChangeInventoryCommand;
import com.kh.burgerstack.inventory.command.InventoryAdjustmentCommand;
import com.kh.burgerstack.inventory.command.InventoryTransactionCreateCommand;
import com.kh.burgerstack.inventory.dao.InventoryDao;
import com.kh.burgerstack.inventory.domain.InventoryTransactionItem;
import com.kh.burgerstack.inventory.domain.StoreInventory;
import com.kh.burgerstack.inventory.dto.InventoryDetailViewModel;
import com.kh.burgerstack.inventory.dto.InventoryListCondition;
import com.kh.burgerstack.inventory.dto.InventoryListViewModel;
import com.kh.burgerstack.store.StoreDao;
import com.kh.burgerstack.store.dto.StoreOption;
import com.kh.burgerstack.user.LoginUser;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InventoryService {
    private final InventoryTransactionService inventoryTransactionService;
    private final InventoryDao inventoryDao;
    private final StoreDao storeDao;

    public InventoryListViewModel getInventoryListView(
            InventoryListCondition condition,
            PagingRequest pagingRequest,
            LoginUser loginUser) {
        if (loginUser.isOwner()) {
            condition.setStoreId(loginUser.getStoreId().intValue());
        }

        validateAccess(loginUser, condition.getStoreId());

        List<InventoryListViewModel.Item> list = inventoryDao.findInventoryListItems(condition, pagingRequest);
        int totalCount = inventoryDao.count(condition);
        List<StoreOption> storeOptions = storeDao.getStoreOptions();

        return new InventoryListViewModel(
                list,
                storeOptions,
                condition,
                pagingRequest.toPageInfo(totalCount));
    }

    public InventoryDetailViewModel getInventoryDetail(int inventoryId, LoginUser loginUser) {
        InventoryDetailViewModel detail = inventoryDao.getInventoryDetailById(inventoryId);
        validateAccess(loginUser, detail.getStoreId());
        return detail;
    }

    @Transactional
    public void adjust(ChangeInventoryCommand command) {
        List<InventoryTransactionItem> inventoryTransactionItems = new ArrayList<>();

        for (ChangeInventoryCommand.Item item : command.getItems()) {
            StoreInventory inventory = find(item.getInventoryId());
            validateAccess(command.getLoginUser(), inventory.getStoreId());

            InventoryTransactionItem inventoryTransactionItem = inventory.changeBy(item.getDeltaQuantity());
            inventoryTransactionItems.add(inventoryTransactionItem);

            inventoryDao.update(inventory);
        }

        inventoryTransactionService.createTransaction(new InventoryTransactionCreateCommand(
                command.getTransactionType(),
                command.getReason(),
                command.getTransactionMemo(),
                command.getLoginUser().getUserNo().intValue(),
                command.getStoreId(),
                command.getReceiptId(),
                command.getStoreClosingId(),
                inventoryTransactionItems));
    }

    @Transactional
    public void adjustQuantity(InventoryAdjustmentCommand command) {
        StoreInventory current = find(command.getInventoryId());

        // 검증은 adjust에서 수행하므로 다루지 않음
        int deltaQuantity = command.getAfterQuantity() - current.getCurrentQuantity();
        List<ChangeInventoryCommand.Item> items = List
                .of(new ChangeInventoryCommand.Item(command.getInventoryId(), deltaQuantity));

        adjust(new ChangeInventoryByAdjustmentCommand(
                command.getLoginUser(),
                items,
                command.getTransactionMemo(),
                command.getReason(),
                current.getStoreId()));
    }

    @Transactional
    public void changeSafetyQuantity(
            int inventoryId,
            int safetyQuantity,
            LoginUser loginUser) {
        StoreInventory inventory = find(inventoryId);
        validateAccess(loginUser, inventory.getStoreId());
        inventory.changeSafetyQuantityTo(safetyQuantity);
        inventoryDao.update(inventory);
    }

    private StoreInventory find(int inventoryId) {
        StoreInventory current = inventoryDao.findById(inventoryId);

        if (current == null) {
            throw new NotFoundException("재고를 찾을 수 없습니다.");
        }

        return current;
    }

    private void validateAccess(LoginUser loginUser, Integer storeId) {
        // 관리자는 접근 가능
        if (loginUser.isAdmin()) {
            return;
        }

        boolean isOwnStore = loginUser.getStoreId() == null ? false
                : loginUser.getStoreId().intValue() == storeId;

        // 점주는 자신의 점포에 접근 가능
        if (loginUser.isOwner() && isOwnStore) {
            return;
        }

        // 해당하지 않으면 거절
        throw new BusinessException("재고에 접근할 권한이 없습니다.");
    }
}

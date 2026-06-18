package com.kh.burgerstack.inventory.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.exception.BusinessException;
import com.kh.burgerstack.exception.NotFoundException;
import com.kh.burgerstack.inventory.command.ChangeInventoryCommand;
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
    public void change(ChangeInventoryCommand command) {
        List<InventoryTransactionItem> inventoryTransactionItems = new ArrayList<>();

        for (ChangeInventoryCommand.Item item : command.getItems()) {
            StoreInventory inventory = find(item.getInventoryId());
            validateAccess(command.getLoginUser(), inventory.getStoreId());

            InventoryTransactionItem inventoryTransactionItem = inventory
                    .change(item.resolveAfterQuantity(inventory.getCurrentQuantity()));
            inventoryTransactionItems.add(inventoryTransactionItem);

            inventoryDao.update(inventory);
        }

        inventoryTransactionService.createTransaction(
                command.getInventoryTransaction(),
                inventoryTransactionItems);
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

package com.kh.burgerstack.inventory.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.exception.BusinessException;
import com.kh.burgerstack.exception.NotFoundException;
import com.kh.burgerstack.inventory.command.ChangeInventoryCommand;
import com.kh.burgerstack.inventory.dao.InventoryDao;
import com.kh.burgerstack.inventory.domain.InventoryTransaction;
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
        List<StoreInventory> inventories = inventoryDao.findByIds(command.getItems().stream()
                .map(item -> item.getInventoryId())
                .toList());

        int storeId = resolveSingleStoreId(inventories);
        validateAccess(command.getLoginUser(), storeId);

        Map<Integer, StoreInventory> inventoryMap = inventories.stream()
                .collect(Collectors.toMap(
                        inventory -> inventory.getStoreInventoryId(),
                        inventory -> inventory));

        List<InventoryTransactionItem> inventoryTransactionItems = new ArrayList<>();

        // 부작용이 포함되어 있으므로 반복문으로 처리
        for (ChangeInventoryCommand.QuantityChange item : command.getItems()) {
            StoreInventory inventory = inventoryMap.get(item.getInventoryId());

            InventoryTransactionItem inventoryTransactionItem = null;

            if (item instanceof ChangeInventoryCommand.FixedQuantityChange fixedQuantityChange) {
                inventoryTransactionItem = inventory
                        .changeTo(fixedQuantityChange.getActualQuantity());
            } else if (item instanceof ChangeInventoryCommand.DeltaQuantityChange deltaQuantityChange) {
                inventoryTransactionItem = inventory
                        .changeBy(deltaQuantityChange.getDeltaQuantity());
            }

            inventoryDao.update(inventory);

            inventoryTransactionItems.add(inventoryTransactionItem);
        }

        InventoryTransaction inventoryTransaction = command.getInventoryTransaction();
        inventoryTransaction.setStoreId(storeId);

        inventoryTransactionService.createTransaction(
                inventoryTransaction,
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

    private int resolveSingleStoreId(List<StoreInventory> inventories) {
        if (inventories.isEmpty()) {
            throw new IllegalArgumentException("재고 변경 대상이 없습니다.");
        }

        int storeId = inventories.get(0).getStoreId();

        for (StoreInventory inventory : inventories) {
            if (inventory.getStoreId() != storeId) {
                throw new IllegalStateException("하나의 재고 변동 이력에는 하나의 점포 재고만 포함될 수 있습니다.");
            }
        }

        return storeId;
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

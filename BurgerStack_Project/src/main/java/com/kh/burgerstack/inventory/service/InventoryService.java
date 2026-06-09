package com.kh.burgerstack.inventory.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.exception.CustomException;
import com.kh.burgerstack.inventory.dao.InventoryDao;
import com.kh.burgerstack.inventory.dto.InventoryAdjustRequest;
import com.kh.burgerstack.inventory.dto.InventoryDetail;
import com.kh.burgerstack.inventory.dto.InventoryListItem;
import com.kh.burgerstack.inventory.dto.InventoryListView;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;
import com.kh.burgerstack.inventory.dto.InventoryTransactionCreateCommand;
import com.kh.burgerstack.inventory.vo.InventoryTransactionItem;
import com.kh.burgerstack.inventory.vo.StoreInventory;
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

    public InventoryListView getInventoryListView(
            InventorySearchCondition condition,
            PagingRequest pagingRequest,
            LoginUser loginUser) {
        if (!loginUser.isAdmin() && condition.getStoreId() != null
                && condition.getStoreId() != loginUser.getStoreId().intValue()) {
            throw new CustomException("재고를 찾을 수 없습니다.");
        }

        List<InventoryListItem> list = inventoryDao.findInventoryListItems(condition, pagingRequest);
        int totalCount = inventoryDao.count(condition);
        List<StoreOption> storeOptions = storeDao.getStoreOptions();

        return new InventoryListView(
                list,
                storeOptions,
                condition,
                pagingRequest.toPageInfo(totalCount));
    }

    public InventoryDetail getInventoryDetail(int inventoryId, LoginUser loginUser) {
        InventoryDetail detail = inventoryDao.getInventoryDetailById(inventoryId);
        if (!loginUser.isAdmin() && detail.getStoreId() != loginUser.getStoreId().intValue()) {
            throw new CustomException("재고를 찾을 수 없습니다.");
        }

        return detail;
    }

    @Transactional
    public void adjust(
            int inventoryId,
            InventoryAdjustRequest inventoryAdjustRequest,
            LoginUser loginUser) {
        StoreInventory inventory = inventoryDao.findById(inventoryId);
        if (!loginUser.isAdmin() && inventory.getStoreId() != loginUser.getStoreId().intValue()) {
            throw new CustomException("재고를 찾을 수 없습니다.");
        }

        if (inventory.getCurrentQuantity() == inventoryAdjustRequest.getAfterQuantity()) {
            throw new CustomException("변경 전과 후의 수량이 동일합니다.");
        }

        inventoryDao.updateQuantity(
                inventoryId,
                inventory.getCurrentQuantity(),
                inventoryAdjustRequest.getAfterQuantity());

        InventoryTransactionItem inventoryTransactionItem = new InventoryTransactionItem(
                inventory.getCurrentQuantity(),
                inventoryAdjustRequest.getAfterQuantity(),
                inventoryId);

        List<InventoryTransactionItem> list = new ArrayList<>();
        list.add(inventoryTransactionItem);

        inventoryTransactionService.createTransaction(new InventoryTransactionCreateCommand(
                "ADJUSTMENT",
                inventoryAdjustRequest.getReason(),
                inventoryAdjustRequest.getTransactionMemo(),
                loginUser.getUserNo().intValue(),
                inventory.getStoreId(),
                null,
                null,
                list));
    }

    @Transactional
    public void changeSafeQuantity(
            int inventoryId,
            int safetyQuantity,
            LoginUser loginUser) {
        StoreInventory inventory = inventoryDao.findById(inventoryId);

        if (!loginUser.isAdmin() && inventory.getStoreId() != loginUser.getStoreId().intValue()) {
            throw new CustomException("재고를 찾을 수 없습니다.");
        }

        if (inventory.getSafetyQuantity() == safetyQuantity) {
            throw new CustomException("변경 전과 후의 안전재고 수량이 동일합니다.");
        }

        inventoryDao.updateSafetyQuantity(inventoryId, safetyQuantity, inventory.getSafetyQuantity());
    }
}

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
import com.kh.burgerstack.user.LoginUser;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InventoryService {
    private final InventoryTransactionService inventoryTransactionService;
    private final InventoryDao inventoryDao;
    private final StoreDao storeDao;

    public InventoryListView getOwnerInventoryListView(
            InventorySearchCondition condition,
            PagingRequest pagingRequest,
            LoginUser loginUser) {
        int storeId = storeDao.findStoreIdByOwnerUserNo(loginUser.getUserNo()).intValue();
        condition.setStoreId(storeId);

        ArrayList<InventoryListItem> list = inventoryDao.findInventoryListItems(condition, pagingRequest);
        return new InventoryListView(list, pagingRequest.toPageInfo(0));
    }

    public InventoryListView getInventoryListView(
            InventorySearchCondition condition,
            PagingRequest pagingRequest) {

        ArrayList<InventoryListItem> list = inventoryDao.findInventoryListItems(condition, pagingRequest);
        int totalCount = inventoryDao.count(condition);
        System.out.println(totalCount);
        return new InventoryListView(list, pagingRequest.toPageInfo(totalCount));
    }

    public InventoryDetail getInventoryDetailById(int inventoryId) {
        return inventoryDao.getInventoryDetailById(inventoryId);
    }

    public InventoryDetail getInventoryDetailById(int inventoryId, int storeId) {
        InventoryDetail detail = inventoryDao.getInventoryDetailById(inventoryId);
        if (detail.getStoreId() != storeId) {
            throw new CustomException("재고를 찾을 수 없습니다.");
        }
        return detail;
    }

    @Transactional
    public void adjust(
            int inventoryId,
            LoginUser loginUser,
            InventoryAdjustRequest inventoryAdjustRequest) {
        StoreInventory inventory = inventoryDao.findById(inventoryId);
        if (loginUser.getRole().equals("OWNER")
                && inventory.getStoreId() != loginUser.getStoreId().intValue()) {
            throw new CustomException("재고를 찾을 수 없습니다.");
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
}

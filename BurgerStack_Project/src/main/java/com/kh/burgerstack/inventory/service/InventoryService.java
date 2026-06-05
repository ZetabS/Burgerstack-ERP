package com.kh.burgerstack.inventory.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dao.InventoryDao;
import com.kh.burgerstack.inventory.dto.InventoryListView;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;
import com.kh.burgerstack.inventory.vo.StoreInventory;
import com.kh.burgerstack.store.StoreDao;
import com.kh.burgerstack.user.LoginUser;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InventoryService {
    private final InventoryDao inventoryDao;
    private final StoreDao storeDao;

    public InventoryListView getOwnerInventoryListView(
            InventorySearchCondition condition,
            PagingRequest pagingRequest,
            LoginUser loginUser) {
        long storeId = storeDao.findStoreIdByOwnerUserNo(loginUser.getUserNo());
        condition.setStoreId(storeId);

        ArrayList<StoreInventory> list = inventoryDao.findInventoryListItems(condition, pagingRequest);
        return new InventoryListView(list, pagingRequest.toPageInfo(0));
    }

    public InventoryListView getInventoryListView(
            InventorySearchCondition condition,
            PagingRequest pagingRequest) {

        ArrayList<StoreInventory> list = inventoryDao.findInventoryListItems(condition, pagingRequest);
        return new InventoryListView(list, pagingRequest.toPageInfo(0));
    }
}

package com.kh.burgerstack.inventory.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventoryDetail;
import com.kh.burgerstack.inventory.dto.InventoryListItem;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InventoryDao {
    private final InventoryMapper inventoryMapper;

    public ArrayList<InventoryListItem> findInventoryListItems(
            InventorySearchCondition condition,
            PagingRequest pagingRequest) {
        return inventoryMapper.findInventoryListItems(condition, pagingRequest);
    }

    public InventoryDetail getInventoryDetailById(int inventoryId) {
        return inventoryMapper.getInventoryDetailById(inventoryId);
    }

    public int count(InventorySearchCondition condition) {
        return inventoryMapper.count(condition);
    }
}

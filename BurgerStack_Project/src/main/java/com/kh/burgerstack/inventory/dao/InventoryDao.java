package com.kh.burgerstack.inventory.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.domain.StoreInventory;
import com.kh.burgerstack.inventory.dto.InventoryDetailViewModel;
import com.kh.burgerstack.inventory.dto.InventoryListCondition;
import com.kh.burgerstack.inventory.dto.InventoryListViewModel;
import com.kh.burgerstack.inventory.exception.InventoryConflictException;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InventoryDao {
    private final InventoryMapper inventoryMapper;

    public StoreInventory findById(int storeInventoryId) {
        return inventoryMapper.findById(storeInventoryId);
    }

    public List<InventoryListViewModel.Item> findInventoryListItems(
            InventoryListCondition condition,
            PagingRequest pagingRequest) {
        return inventoryMapper.findInventoryListItems(condition, pagingRequest);
    }

    public InventoryDetailViewModel getInventoryDetailById(int inventoryId) {
        return inventoryMapper.getInventoryDetailById(inventoryId);
    }

    public int count(InventoryListCondition condition) {
        return inventoryMapper.count(condition);
    }

    public void update(StoreInventory inventory) {
        int updatedCount = inventoryMapper.update(inventory);
        if (updatedCount != 1) {
            throw new InventoryConflictException();
        }
    }
}

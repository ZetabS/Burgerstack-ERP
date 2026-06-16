package com.kh.burgerstack.inventory.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventoryChangeParam;
import com.kh.burgerstack.inventory.dto.InventoryDetail;
import com.kh.burgerstack.inventory.dto.InventoryListItem;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;
import com.kh.burgerstack.inventory.exception.InventoryConflictException;
import com.kh.burgerstack.inventory.vo.StoreInventory;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InventoryDao {
    private final InventoryMapper inventoryMapper;

    public List<InventoryListItem> findInventoryListItems(
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

    public void updateQuantity(InventoryChangeParam param) {
        int updatedCount = inventoryMapper.updateQuantity(param);
        if (updatedCount != 1) {
            throw new InventoryConflictException();
        }
    }

    public StoreInventory findById(
            int storeInventoryId) {
        return inventoryMapper.findById(storeInventoryId);
    }

    public void updateSafetyQuantity(
            int storeInventoryId,
            int safetyQuantity,
            int currentSafetyQuantity) {
        int updatedCount = inventoryMapper.updateSafetyQuantity(
                storeInventoryId,
                safetyQuantity,
                currentSafetyQuantity);
        if (updatedCount <= 0) {
            throw new InventoryConflictException();
        }
    }
}

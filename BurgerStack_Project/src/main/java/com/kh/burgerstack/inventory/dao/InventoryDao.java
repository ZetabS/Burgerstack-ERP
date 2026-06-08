package com.kh.burgerstack.inventory.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.exception.CustomException;
import com.kh.burgerstack.inventory.dto.InventoryDetail;
import com.kh.burgerstack.inventory.dto.InventoryListItem;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;
import com.kh.burgerstack.inventory.vo.StoreInventory;

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

    public void updateQuantity(
            int storeInventoryId,
            int beforeQuantity,
            int afterQuantity) {
        int result = inventoryMapper.updateQuantity(storeInventoryId, beforeQuantity, afterQuantity);
        if (result <= 0) {
            throw new CustomException("재고 수량을 조정할 수 없습니다.");
        }
    }

    public StoreInventory findById(
            int storeInventoryId) {
        return inventoryMapper.findById(storeInventoryId);
    }
}

package com.kh.burgerstack.inventory;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InventoryDao {
    private final InventoryMapper inventoryMapper;

    public ArrayList<StoreInventory> findInventoryListItems(
            InventorySearchCondition condition,
            PagingRequest pagingRequest) {
        return inventoryMapper.findInventoryListItems(condition, pagingRequest);
    }
}

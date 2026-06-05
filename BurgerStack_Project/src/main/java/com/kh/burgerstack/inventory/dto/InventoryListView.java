package com.kh.burgerstack.inventory.dto;

import java.util.ArrayList;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.inventory.vo.StoreInventory;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class InventoryListView {
    private final ArrayList<StoreInventory> list;
    private final PageInfo pageInfo;
}

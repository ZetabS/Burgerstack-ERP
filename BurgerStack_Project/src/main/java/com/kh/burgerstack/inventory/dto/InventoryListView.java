package com.kh.burgerstack.inventory.dto;

import java.util.ArrayList;

import com.kh.burgerstack.common.pagination.PageInfo;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class InventoryListView {
    private final ArrayList<InventoryListItem> list;
    private final PageInfo pageInfo;
}

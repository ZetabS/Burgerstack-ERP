package com.kh.burgerstack.inventory.dto;

import java.util.List;

import com.kh.burgerstack.common.pagination.PageInfo;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class InventoryTransactionListView {
    private final List<InventoryTransactionListItem> list;
    private final PageInfo pageInfo;
}

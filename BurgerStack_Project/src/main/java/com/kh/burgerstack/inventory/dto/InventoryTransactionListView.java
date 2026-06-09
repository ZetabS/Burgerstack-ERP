package com.kh.burgerstack.inventory.dto;

import java.util.List;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.store.dto.StoreOption;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class InventoryTransactionListView {
    private final List<InventoryTransactionListItem> list;
    private final List<StoreOption> storeOptions;
    private final InventoryTransactionSearchCondition condition;
    private final PageInfo pageInfo;
}

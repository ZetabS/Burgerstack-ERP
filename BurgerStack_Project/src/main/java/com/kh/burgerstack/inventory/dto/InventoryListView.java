package com.kh.burgerstack.inventory.dto;

import java.util.List;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.store.dto.StoreOption;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class InventoryListView {
    private final List<InventoryListItem> list;
    private final List<StoreOption> storeOptions;
    private final InventorySearchCondition condition;
    private final PageInfo pageInfo;
}

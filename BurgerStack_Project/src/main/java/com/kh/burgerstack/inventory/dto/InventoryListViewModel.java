package com.kh.burgerstack.inventory.dto;

import java.util.List;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.store.dto.StoreOption;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@AllArgsConstructor
public class InventoryListViewModel {
    private final List<InventoryListViewModel.Item> list;
    private final List<StoreOption> storeOptions;
    private final InventoryListCondition condition;
    private final PageInfo pageInfo;

    @AllArgsConstructor
    @NoArgsConstructor
    @Getter
    @Setter
    @ToString
    public static class Item {
        private Integer inventoryId;
        private Integer currentQuantity;
        private Integer shortageQuantity;
        private Integer safetyQuantity;
        private String storeName;
        private String materialCode;
        private String materialName;
        private String materialType;
    }
}

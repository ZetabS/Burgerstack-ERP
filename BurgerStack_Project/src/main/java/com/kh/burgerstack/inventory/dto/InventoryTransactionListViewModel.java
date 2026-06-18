package com.kh.burgerstack.inventory.dto;

import java.time.LocalDateTime;
import java.util.List;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.store.dto.StoreOption;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
public class InventoryTransactionListViewModel {
    private final List<InventoryTransactionListViewModel.Item> list;
    private final List<StoreOption> storeOptions;
    private final InventoryTransactionListCondition condition;
    private final PageInfo pageInfo;

    @NoArgsConstructor
    @AllArgsConstructor
    @Getter
    @Setter
    @ToString
    public static class Item {
        private Integer inventoryTransactionId;
        private String inventoryTransactionCode;
        private String transactionType;
        private String reason;
        private LocalDateTime createdAt;
        private Integer createdBy;
        private String createdByName;
        private String storeName;
        private Integer storeId;
    }
}

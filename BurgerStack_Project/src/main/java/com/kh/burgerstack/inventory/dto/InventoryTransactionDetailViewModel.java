package com.kh.burgerstack.inventory.dto;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class InventoryTransactionDetailViewModel {
    private Integer inventoryTransactionId;
    private String inventoryTransactionCode;
    private String transactionType;
    private String reason;
    private String transactionMemo;
    private LocalDateTime createdAt;
    private Integer createdBy;
    private String createdByName;
    private String storeName;
    private Integer storeId;

    private List<InventoryTransactionDetailViewModel.Item> list;

    @NoArgsConstructor
    @AllArgsConstructor
    @Getter
    @Setter
    @ToString
    public static class Item {
        private Integer inventoryTransactionItemId;
        private Integer beforeQuantity;
        private Integer changedQuantity;
        private Integer afterQuantity;
        private String materialCode;
        private String materialType;
        private String materialName;
        private Integer inventoryTransactionId;
        private Integer storeInventoryId;
        private Integer materialId;
    }

}

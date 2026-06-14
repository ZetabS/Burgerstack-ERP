package com.kh.burgerstack.inventory.dto;

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
public class InventoryTransactionDetailItem {
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

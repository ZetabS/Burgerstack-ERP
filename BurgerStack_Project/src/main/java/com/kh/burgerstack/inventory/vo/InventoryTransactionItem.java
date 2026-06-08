package com.kh.burgerstack.inventory.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class InventoryTransactionItem {
    private Integer inventoryTransactionItemId;
    private Integer beforeQuantity;
    private Integer afterQuantity;
    private Integer inventoryTransactionId;
    private Integer storeInventoryId;
}

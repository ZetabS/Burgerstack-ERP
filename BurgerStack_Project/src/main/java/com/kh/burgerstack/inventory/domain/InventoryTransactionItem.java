package com.kh.burgerstack.inventory.domain;

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

    public InventoryTransactionItem(
            Integer beforeQuantity,
            Integer afterQuantity,
            Integer storeInventoryId) {
        this.beforeQuantity = beforeQuantity;
        this.afterQuantity = afterQuantity;
        this.storeInventoryId = storeInventoryId;
    }

}

package com.kh.burgerstack.inventory;

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

    private Long inventoryTransactionItemId;
    private Long inventoryTransactionId;
    private Long materialId;
    private Long beforeQuantity;
    private Long changeQuantity;
    private Long afterQuantity;
}

package com.kh.burgerstack.inventory.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public class InventoryChangeParam {
    private int inventoryId;
    private int beforeQuantity;
    private int afterQuantity;
}

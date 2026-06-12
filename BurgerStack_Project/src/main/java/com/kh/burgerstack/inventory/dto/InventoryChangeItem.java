package com.kh.burgerstack.inventory.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public class InventoryChangeItem {
    private int inventoryId; // 재고 ID
    private int deltaQuantity; // 변경 수량
}

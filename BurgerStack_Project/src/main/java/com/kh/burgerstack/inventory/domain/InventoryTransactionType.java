package com.kh.burgerstack.inventory.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum InventoryTransactionType {
    RECEIPT("입고"),
    STORE_CLOSING("마감"),
    ADJUSTMENT("조정");

    private String label;
}

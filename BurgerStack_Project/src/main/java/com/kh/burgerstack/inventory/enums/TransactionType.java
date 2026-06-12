package com.kh.burgerstack.inventory.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum TransactionType {
    RECEIPT("입고"),
    STORE_CLOSING("마감"),
    ADJUSTMENT("조정");

    private String label;
}

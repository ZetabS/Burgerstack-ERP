package com.kh.burgerstack.inventory.dto;

import com.kh.burgerstack.user.LoginUser;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class InventoryAdjustmentCommand {
    private int inventoryId;
    private Integer afterQuantity;
    private String reason;
    private String transactionMemo;
    private LoginUser loginUser;
}

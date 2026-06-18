package com.kh.burgerstack.inventory.command;

import com.kh.burgerstack.user.LoginUser;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public class InventoryAdjustmentCommand {
    private int inventoryId;
    private int afterQuantity;
    private String reason;
    private String transactionMemo;
    private LoginUser loginUser;
}

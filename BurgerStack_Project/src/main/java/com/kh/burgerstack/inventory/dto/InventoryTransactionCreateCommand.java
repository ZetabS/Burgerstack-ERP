package com.kh.burgerstack.inventory.dto;

import java.util.List;

import com.kh.burgerstack.inventory.enums.TransactionType;

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
public class InventoryTransactionCreateCommand {
    private TransactionType transactionType;
    private String reason;
    private String transactionMemo;

    private Integer createdBy;
    private Integer storeId;
    private Integer receiptId;
    private Integer storeClosingId;

    private List<InventoryChangeParam> inventoryTransactionItems;
}

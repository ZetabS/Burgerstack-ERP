package com.kh.burgerstack.inventory.command;

import java.util.List;

import com.kh.burgerstack.inventory.domain.InventoryTransactionType;
import com.kh.burgerstack.inventory.dto.InventoryChangeParam;

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
    private InventoryTransactionType transactionType;
    private String reason;
    private String transactionMemo;

    private Integer createdBy;
    private Integer storeId;
    private Integer receiptId;
    private Integer storeClosingId;

    private List<InventoryChangeParam> inventoryTransactionItems;
}

package com.kh.burgerstack.inventory.dto;

import java.util.List;

import com.kh.burgerstack.inventory.vo.InventoryTransaction;
import com.kh.burgerstack.inventory.vo.InventoryTransactionItem;

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
    private String transactionType;
    private String reason;
    private String transactionMemo;

    private Integer createdBy;
    private Integer storeId;
    private Integer receiptId;
    private Integer storeClosingId;

    private List<InventoryTransactionItem> inventoryTransactionItems;

    public InventoryTransaction getInventoryTransaction() {
        InventoryTransaction inventoryTransaction = new InventoryTransaction(
                null,
                getTransactionType(),
                getReason(),
                getTransactionMemo(),
                null,
                getCreatedBy(),
                getStoreId(),
                getReceiptId(),
                getStoreClosingId());
        return inventoryTransaction;
    }
}

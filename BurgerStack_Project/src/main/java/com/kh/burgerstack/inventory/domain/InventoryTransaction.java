package com.kh.burgerstack.inventory.domain;

import java.time.LocalDateTime;

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
public class InventoryTransaction {
    private Integer inventoryTransactionId;
    private InventoryTransaction.Type transactionType;
    private String reason;
    private String transactionMemo;
    private LocalDateTime createdAt;
    private Integer createdBy;
    private Integer storeId;
    private Integer receiptId;
    private Integer storeClosingId;

    @AllArgsConstructor
    @Getter
    public enum Type {
        RECEIPT("입고"),
        STORE_CLOSING("마감"),
        ADJUSTMENT("조정");

        private String label;
    }
}

package com.kh.burgerstack.inventory;

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
    private Long inventoryTransactionId;
    private String transactionType;
    private String reason;
    private String transactionMemo;
    private LocalDateTime createdAt;
    private Long createdBy;
    private Long storeId;
    private Long receiptId;
    private Long storeClosingId;
}

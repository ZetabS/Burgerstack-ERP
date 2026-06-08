package com.kh.burgerstack.inventory.vo;

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
    private String transactionType;
    private String reason;
    private String transactionMemo;
    private LocalDateTime createdAt;
    private Integer createdBy;
    private Integer storeId;
    private Integer receiptId;
    private Integer storeClosingId;
}

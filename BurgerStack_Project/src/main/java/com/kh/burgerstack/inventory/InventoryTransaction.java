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
    private Long storeId;
    private String sourceType;
    private Long sourceId;
    private String transactionMemo;
    private Long createdBy;
    private LocalDateTime createdAt;
}

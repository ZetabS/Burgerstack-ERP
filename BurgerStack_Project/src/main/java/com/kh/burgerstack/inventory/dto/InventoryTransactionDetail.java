package com.kh.burgerstack.inventory.dto;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class InventoryTransactionDetail {
    private Integer inventoryTransactionId;
    private String transactionType;
    private String reason;
    private String transactionMemo;
    private LocalDateTime createdAt;
    private Integer createdBy;
    private String createdByName;
    private String storeName;
    private Integer storeId;

    private List<InventoryTransactionDetailItem> list;
}

package com.kh.burgerstack.inventory.dto;

import java.time.LocalDateTime;

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
public class InventoryTransactionListItem {
    private Integer inventoryTransactionId;
    private String transactionType;
    private String reason;
    private LocalDateTime createdAt;
    private Integer createdBy;
    private String createdByName;
    private String storeName;
    private Integer storeId;

}

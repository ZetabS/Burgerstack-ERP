package com.kh.burgerstack.inventory.dto;

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
public class InventoryListItem {
    private Long storeInventoryId;
    private Long storeId;
    private Long materialId;
    private Long currentQuantity;
    private Long safetyQuantity;
    private Long createdBy;
    private LocalDateTime createdAt;
    private Long updatedBy;
    private LocalDateTime updatedAt;
    private String storeName;
    private String materialName;
}

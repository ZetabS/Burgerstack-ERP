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
public class InventoryDetail {
    private Long storeInventoryId;
    private Long currentQuantity;
    private Long safetyQuantity;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String storeName;
    private String materialName;
    private Long storeId;
    private Long materialId;
}

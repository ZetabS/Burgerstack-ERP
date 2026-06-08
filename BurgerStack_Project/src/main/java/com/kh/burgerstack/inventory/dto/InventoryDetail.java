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
    private Integer storeInventoryId;
    private Integer currentQuantity;
    private Integer safetyQuantity;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String storeName;
    private String materialName;
    private Integer storeId;
    private Integer materialId;
}

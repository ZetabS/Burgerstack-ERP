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
public class StoreInventory {
    private Integer storeInventoryId;
    private Integer currentQuantity;
    private Integer safetyQuantity;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Integer storeId;
    private Integer materialId;
}

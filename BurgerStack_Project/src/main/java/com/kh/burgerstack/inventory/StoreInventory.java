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
public class StoreInventory {
    private Long storeInventoryId;
    private Long currentQuantity;
    private Long safetyQuantity;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Long storeId;
    private Long materialId;
}

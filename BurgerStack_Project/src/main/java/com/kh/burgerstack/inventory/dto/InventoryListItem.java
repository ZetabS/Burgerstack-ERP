package com.kh.burgerstack.inventory.dto;

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
    private Integer inventoryId;
    private Integer currentQuantity;
    private Integer safetyQuantity;
    private String storeName;
    private String materialName;
}

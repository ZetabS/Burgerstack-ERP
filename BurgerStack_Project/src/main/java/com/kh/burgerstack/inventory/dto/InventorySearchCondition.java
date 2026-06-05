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
public class InventorySearchCondition {
    private Long storeId;
    private Long materialId;
    private String materialName;
    private String materialType;
    private Boolean belowSafetyStock;
}

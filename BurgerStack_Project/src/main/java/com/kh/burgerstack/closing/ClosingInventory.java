package com.kh.burgerstack.closing;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClosingInventory {

    private Long storeInventoryId;
    private Long currentQuantity;
    private Long materialId;
    private String materialName;
}
package com.kh.burgerstack.receipt;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class ReceiptTransactionItemParam {

    private Long inventoryTransactionId;
    private Long storeInventoryId;
    private Long beforeQuantity;
    private Long afterQuantity;
}
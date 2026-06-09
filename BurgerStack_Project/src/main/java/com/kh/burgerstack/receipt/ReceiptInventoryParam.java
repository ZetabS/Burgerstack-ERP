package com.kh.burgerstack.receipt;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReceiptInventoryParam {

    private Long storeId;
    private Long purchaseOrderItemId;
    private Long receivedQuantity;

    public ReceiptInventoryParam(Long storeId, Long purchaseOrderItemId, Long receivedQuantity) {
        this.storeId = storeId;
        this.purchaseOrderItemId = purchaseOrderItemId;
        this.receivedQuantity = receivedQuantity;
    }
}
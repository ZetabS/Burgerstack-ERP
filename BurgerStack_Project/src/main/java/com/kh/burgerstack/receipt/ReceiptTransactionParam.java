package com.kh.burgerstack.receipt;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReceiptTransactionParam {

    private Long inventoryTransactionId;
    private Long storeId;
    private Long receiptId;
    private Long createdBy;

    public ReceiptTransactionParam(Long storeId, Long receiptId, Long createdBy) {
        this.storeId = storeId;
        this.receiptId = receiptId;
        this.createdBy = createdBy;
    }
}
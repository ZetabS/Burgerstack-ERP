package com.kh.burgerstack.receipt.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ReceiptItems {

    private int receiptItemId;          // RECEIPT_ITEM_ID	NUMBER
    private int receiptId;              // RECEIPT_ID	NUMBER
    private int purchaseReqeustItemId;  // PURCHASE_REQUEST_ITEM_ID	NUMBER
    private int materialId;             // MATERIAL_ID	NUMBER
    private int approvedQuantity;       // APPROVED_QUANTITY	NUMBER(10,0)
    private int receivedQuantity;       // RECEIVED_QUANTITY	NUMBER(10,0)
    private int defectQuantity;         // DEFECT_QUANTITY	NUMBER(10,0)
    private String receiptItemMemo;     // RECEIPT_ITEM_MEMO	VARCHAR2(1000 BYTE)
}

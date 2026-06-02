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
public class Receipt {

    private int receiptId;              // RECEIPT_ID	        NUMBER	            입고 ID
    private int purchaseRequestId;      // PURCHASE_REQUEST_ID	NUMBER              발주 요청 ID
    private int storeId;                // STORE_ID	            NUMBER	            점포 ID
    private String receiptMemo;         // RECEIPT_MEMO	        VARCHAR2(1000 BYTE)	입고 메모
    private int receivedBy;             // RECEIVED_BY	        NUMBER	            입고 처리자 ID
    private String receivedAt;          // RECEIVED_AT	        DATE	            입고 처리일시

}

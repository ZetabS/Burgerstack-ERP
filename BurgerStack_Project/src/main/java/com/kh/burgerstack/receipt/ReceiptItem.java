package com.kh.burgerstack.receipt;

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
public class ReceiptItem {
    private Long receiptItemId;
    private Long receivedQuantity;
    private Long defectQuantity;
    private String receiptItemMemo;
    private Long receiptId;
    private Long purchaseOrderItemId;
}

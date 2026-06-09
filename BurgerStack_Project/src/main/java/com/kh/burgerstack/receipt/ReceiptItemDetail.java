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
public class ReceiptItemDetail {

    private String materialCode;
    private String materialName;
    private String materialType;

    private Long supplyPrice;
    private Long requestQuantity;

    private Long receivedQuantity;
    private Long defectQuantity;

    private String receiptItemMemo;

    private Long amount;
}
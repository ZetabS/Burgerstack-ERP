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
public class ReceiptCheckItemDto {

    private Long purchaseOrderItemId;

    private String materialCode;

    private String materialType;

    private String materialName;

    // 발주수량
    private Long requestQuantity;

    // 승인수량
    private Long approvedQuantity;

    // 반려수량
    private Long rejectedQuantity;

    // 반려사유
    private String rejectReason;

    private Long supplyPrice;

    private Long amount;
}
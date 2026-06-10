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

    private Long approvedQuantity;

    private Long supplyPrice;

    private Long amount;
}
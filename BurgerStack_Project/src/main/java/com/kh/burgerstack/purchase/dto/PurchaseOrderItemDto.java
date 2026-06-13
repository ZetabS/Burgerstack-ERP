package com.kh.burgerstack.purchase.dto;

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
public class PurchaseOrderItemDto {

    private Long purchaseOrderId;
    private Long materialId;
    private String materialNameSnapshot;
    private Long supplyPriceSnapshot;
    private Long requestQuantity;
    private String orderMemo;
}

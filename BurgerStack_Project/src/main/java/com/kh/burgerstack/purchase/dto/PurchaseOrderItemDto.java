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
    private Long unitPriceSnapshot;
    private Long requestQuantity;
}

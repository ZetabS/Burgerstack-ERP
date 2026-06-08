package com.kh.burgerstack.purchase.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PurchaseOrderDetailDto {

    private Long purchaseOrderId;
    private int materialId;
    private String materialName;
    private int supplyPriceSnapshot;
    private int currentQuantity;
    private int requestQuantity;
    private int totalPrice;

    private String Status;

}

package com.kh.burgerstack.purchase.dto;

import java.time.LocalDateTime;

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
    private int approvedQuantity;
    private int totalPrice;

    private LocalDateTime createdAt;

    private String status;

}

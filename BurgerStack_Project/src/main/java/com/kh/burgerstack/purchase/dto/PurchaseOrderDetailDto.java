package com.kh.burgerstack.purchase.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PurchaseOrderDetailDto {

    private int purchaseOrderId;
    private String purchaseCode;
    private int storeId;
    private String storeName;
    private String userName;
    private String role; // 사용자 역할 (예: 점장, 관리자)
    private int materialId;
    private String materialCode;
    private String materialName;
    private String materialType;
    private int supplyPriceSnapshot;
    private int currentQuantity;
    private int requestQuantity;
    private int approvedQuantity;
    private int totalPrice;

    private LocalDateTime createdAt;

    private String status;

    private String orderMemo;

    private String rejectReason;

}

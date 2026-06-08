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
public class PurchaseOrderDto {
    
    private Long purchaseOrderId;
    private Long totalAmount;
    private String orderMemo;
    private Long storeId;
}

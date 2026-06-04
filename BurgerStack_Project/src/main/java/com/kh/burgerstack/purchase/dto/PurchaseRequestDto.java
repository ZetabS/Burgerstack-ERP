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
public class PurchaseRequestDto {
    
    private Long purchaseRequestId;
    private Long storeId;
    private String requestMemo;
    private Long createdBy;   // Long 맞춤
    private Long totalAmount;
}

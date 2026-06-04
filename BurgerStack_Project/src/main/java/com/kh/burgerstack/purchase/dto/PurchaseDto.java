package com.kh.burgerstack.purchase.dto;

import java.math.BigDecimal;

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
public class PurchaseDto {
    
    private Long purchaseRequestId;  // 발주 요청 ID
    private Long storeId;            // 점포 ID
    private String status;          // 상태
    private BigDecimal totalAmount;        // 총 금액
    private String requestMemo;     // 요청 메모
    private Long createdBy;          // 등록자
    private String createdAt;       // 등록일
    
    private String itemSummary;     // 품목 요약
}

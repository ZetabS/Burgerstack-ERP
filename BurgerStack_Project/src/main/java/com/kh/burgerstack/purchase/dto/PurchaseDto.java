package com.kh.burgerstack.purchase.dto;

import java.util.List;

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

    private Long purchaseOrderId; // 발주 요청 ID
    private String purchaseCode; // 발주 요청 코드 (예: P20240001)
    private Long storeId; // 점포 ID
    private String storeName; // 점포명
    private Long totalAmount; // 총 금액
    private String orderMemo;
    private String status; // 상태
    private String createdAt; // 등록일
    private String itemSummary; // 품목 요약

    private List<PurchaseOrderDetailDto> items;
    private Long materialId;
}

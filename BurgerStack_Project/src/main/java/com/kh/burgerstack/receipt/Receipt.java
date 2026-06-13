package com.kh.burgerstack.receipt;

import java.time.LocalDateTime;

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
public class Receipt {

    private Long receiptId;
    private String receiptCode;

    private String receiptMemo;

    private LocalDateTime receivedAt;

    private Long purchaseOrderId;

    private String materialSummary;
    private String receiptStatus;

    // 관리자 입고 이력에서 사용할 예정
    private String storeName;
    private String purchaseCode;
}
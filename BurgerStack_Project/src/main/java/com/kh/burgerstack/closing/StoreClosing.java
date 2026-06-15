package com.kh.burgerstack.closing;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class StoreClosing {
    private Long storeClosingId;

    private LocalDate businessDate;
    private String closingMemo;
    private LocalDateTime closedAt;

    private Long storeId;

    // 관리자 마감 목록/상세에서 사용
    private String storeName;

    private String closingCode;
}
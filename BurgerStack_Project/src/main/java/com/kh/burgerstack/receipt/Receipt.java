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
    private String receiptMemo;
    private LocalDateTime receivedAt;
    private Long purchaseOrderId;
}

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
public class ReceiptPlanDto {

    private Long purchaseOrderId;

    private Long totalAmount;

    private String status;

    private LocalDateTime createdAt;

    private String materialSummary;
}
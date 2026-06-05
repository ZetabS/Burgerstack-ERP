package com.kh.burgerstack.purchase;

import java.math.BigDecimal;
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
public class PurchaseOrder {
    private Long purchaseOrderId;
    private BigDecimal totalAmount;
    private String orderMemo;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Long storeId;
}

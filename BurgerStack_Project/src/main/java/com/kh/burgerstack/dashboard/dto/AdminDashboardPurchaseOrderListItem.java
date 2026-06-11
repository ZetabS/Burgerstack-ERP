package com.kh.burgerstack.dashboard.dto;

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
public class AdminDashboardPurchaseOrderListItem {
    private Long purchaseOrderId;
    private String purchaseCode;
    private BigDecimal totalAmount;
    private String status;
    private LocalDateTime createdAt;
    private String storeName;
    private Long storeId;
}

package com.kh.burgerstack.purchase;

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
public class PurchaseOrderHistory {
    private Long purchaseOrderHistoryId;
    private String toStatus;
    private String reason;
    private LocalDateTime createdAt;
    private Long createdBy;
    private Long purchaseOrderId;
}

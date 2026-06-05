package com.kh.burgerstack.purchase;

import java.math.BigDecimal;

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
public class PurchaseOrderItem {
    private Long purchaseOrderItemId;
    private Long requestQuantity;
    private Long approvedQuantity;
    private String rejectReason;
    private String materialNameSnapshot;
    private BigDecimal supplyPriceSnapshot;
    private Long materialId;
    private Long purchaseOrderId;
}

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
public class PurchaseRequestItem {

    private Long purchaseRequestItemId;
    private Long purchaseRequestId;
    private Long materialId;
    private String materialNameSnapshot;
    private BigDecimal unitPriceSnapshot;
    private Long requestQuantity;
    private Long approvedQuantity;
    private String itemStatus;
    private String rejectReason;
    private BigDecimal subtotalAmount;
}

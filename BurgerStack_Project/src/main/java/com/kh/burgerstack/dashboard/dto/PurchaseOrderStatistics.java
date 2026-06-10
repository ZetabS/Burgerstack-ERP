package com.kh.burgerstack.dashboard.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public class PurchaseOrderStatistics {
    private int requestedCount;
    private int approvedCount;
    private int rejectedCount;
}
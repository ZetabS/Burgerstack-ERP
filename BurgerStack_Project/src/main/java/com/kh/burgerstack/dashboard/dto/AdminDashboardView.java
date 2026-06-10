package com.kh.burgerstack.dashboard.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public class AdminDashboardView {
    private int storeCount;
    private int purchaseCount;
    private int inquiryCount;
    private int belowSafetyInventoryCount;

    private List<AdminDashboardPurchaseOrderListItem> recentPurchaseOrderList;
    private List<AdminDashboardInquiryListItem> recentInquiryList;

    private StoreStatistics storeStatistics;
    private PurchaseOrderStatistics purchaseOrderStatistics;
}

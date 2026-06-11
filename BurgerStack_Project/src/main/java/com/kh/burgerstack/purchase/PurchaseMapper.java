package com.kh.burgerstack.purchase;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.burgerstack.dashboard.dto.AdminDashboardPurchaseOrderListItem;
import com.kh.burgerstack.dashboard.dto.PurchaseOrderStatistics;

@Mapper
public interface PurchaseMapper {
    public List<AdminDashboardPurchaseOrderListItem> findTopN(
            @Param("count") int count);

    public PurchaseOrderStatistics getPurchaseOrderStatistics();
}

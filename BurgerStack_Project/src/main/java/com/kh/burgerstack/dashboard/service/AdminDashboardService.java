package com.kh.burgerstack.dashboard.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.burgerstack.dashboard.dto.AdminDashboardInquiryListItem;
import com.kh.burgerstack.dashboard.dto.AdminDashboardPurchaseOrderListItem;
import com.kh.burgerstack.dashboard.dto.AdminDashboardView;
import com.kh.burgerstack.dashboard.dto.PurchaseOrderStatistics;
import com.kh.burgerstack.dashboard.dto.StoreStatistics;
import com.kh.burgerstack.inquiry.InquiryDaoHO;
import com.kh.burgerstack.inventory.dao.InventoryDao;
import com.kh.burgerstack.inventory.dto.InventoryListCondition;
import com.kh.burgerstack.purchase.PurchaseDao;
import com.kh.burgerstack.purchase.dto.PurchaseSearchDto;
import com.kh.burgerstack.store.StoreDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminDashboardService {
    private final SqlSessionTemplate sqlSession;
    private final StoreDao storeDao;
    private final PurchaseDao purchaseDao;
    private final InventoryDao inventoryDao;
    private final InquiryDaoHO inquiryDao;

    public AdminDashboardView getAdminDashboardView() {
        int storeCount = storeDao.selectStoreCount(sqlSession, null);
        int purchaseCount = purchaseDao.selectPurchaseCount(new PurchaseSearchDto(
                "REQUESTED",
                null,
                null,
                null,
                null,
                true),
                sqlSession);
        int inquiryCount = inquiryDao.countUnanswerd();

        int belowSafetyInventoryCount = inventoryDao.count(new InventoryListCondition(
                null,
                null,
                null,
                true));

        List<AdminDashboardInquiryListItem> recentInquiryList = inquiryDao.findRecent(5);
        List<AdminDashboardPurchaseOrderListItem> recentPurchaseOrderList = purchaseDao.findRecent(5);

        StoreStatistics storeStatistics = storeDao.getStoreStatistics();
        PurchaseOrderStatistics purchaseOrderStatistics = purchaseDao.getPurchaseOrderStatistics();

        return new AdminDashboardView(
                storeCount,
                purchaseCount,
                inquiryCount,
                belowSafetyInventoryCount,
                recentPurchaseOrderList,
                recentInquiryList,
                storeStatistics,
                purchaseOrderStatistics);
    }
}

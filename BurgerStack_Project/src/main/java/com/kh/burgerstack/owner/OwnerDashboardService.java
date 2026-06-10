package com.kh.burgerstack.owner;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OwnerDashboardService {

    @Autowired
    private OwnerDashboardDao dashboardDao;

    public int selectShortageCount() {
        return dashboardDao.selectShortageCount();
    }

    public int selectTodayReceiptCount() {
        return dashboardDao.selectTodayReceiptCount();
    }

    public int selectPendingPurchaseCount() {
        return dashboardDao.selectPendingPurchaseCount();
    }

    public int selectUnansweredInquiryCount() {
        return dashboardDao.selectUnansweredInquiryCount();
    }

    public List<Map<String, Object>> selectShortageTop5() {
        return dashboardDao.selectShortageTop5();
    }

    public List<Map<String, Object>> selectTodayReceiptList() {
        return dashboardDao.selectTodayReceiptList();
    }

    public List<Map<String, Object>> selectPurchaseStatusList() {
        return dashboardDao.selectPurchaseStatusList();
    }

    public Map<String, Object> selectTodayClosing() {
        return dashboardDao.selectTodayClosing();
    }

    public List<Map<String, Object>> selectNoticeList() {
        return dashboardDao.selectNoticeList();
    }
}
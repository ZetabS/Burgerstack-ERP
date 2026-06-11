package com.kh.burgerstack.owner;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.burgerstack.store.Store;

@Service
public class OwnerDashboardService {

    @Autowired
    private OwnerDashboardDao dashboardDao;


    // 로그인한 점주의 점포 조회
    public Store selectStoreByOwnerUserNo(long ownerUserNo) {
        return dashboardDao.selectStoreByOwnerUserNo(ownerUserNo);
    }


    // 재고 부족 품목 개수
    public int selectShortageCount(long storeId) {
        return dashboardDao.selectShortageCount(storeId);
    }


    // 오늘 입고 예정 개수
    public int selectTodayReceiptCount(long storeId) {
        return dashboardDao.selectTodayReceiptCount(storeId);
    }


    // 승인 대기 발주 개수
    public int selectPendingPurchaseCount(long storeId) {
        return dashboardDao.selectPendingPurchaseCount(storeId);
    }


    // 미답변 문의 개수
    public int selectUnansweredInquiryCount(long storeId) {
        return dashboardDao.selectUnansweredInquiryCount(storeId);
    }


    // 재고 부족 TOP5
    public List<Map<String, Object>> selectShortageTop5(long storeId) {
        return dashboardDao.selectShortageTop5(storeId);
    }


    // 오늘 입고 예정 목록
    public List<Map<String, Object>> selectTodayReceiptList(long storeId) {
        return dashboardDao.selectTodayReceiptList(storeId);
    }


    // 미처리 발주 상태 목록
    public List<Map<String, Object>> selectPurchaseStatusList(long storeId) {
        return dashboardDao.selectPurchaseStatusList(storeId);
    }


    // 오늘 마감 정보
    public Map<String, Object> selectTodayClosing(long storeId) {
        return dashboardDao.selectTodayClosing(storeId);
    }


    // 공지사항은 전체 공지라서 storeId 안 받음
    public List<Map<String, Object>> selectNoticeList() {
        return dashboardDao.selectNoticeList();
    }
}
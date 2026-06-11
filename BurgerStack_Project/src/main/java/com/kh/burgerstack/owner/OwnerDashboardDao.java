package com.kh.burgerstack.owner;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.store.Store;

@Repository
public class OwnerDashboardDao {

    @Autowired
    private SqlSessionTemplate sqlSession;


    // 로그인한 점주의 점포 조회
    public Store selectStoreByOwnerUserNo(long ownerUserNo) {
        return sqlSession.selectOne(
            "ownerMapper.selectStoreByOwnerUserNo",
            ownerUserNo
        );
    }


    // 재고 부족 품목 개수
    public int selectShortageCount(long storeId) {
        return sqlSession.selectOne(
            "ownerMapper.selectShortageCount",
            storeId
        );
    }


    // 오늘 입고 예정 개수
    public int selectTodayReceiptCount(long storeId) {
        return sqlSession.selectOne(
            "ownerMapper.selectTodayReceiptCount",
            storeId
        );
    }


    // 승인 대기 발주 개수
    public int selectPendingPurchaseCount(long storeId) {
        return sqlSession.selectOne(
            "ownerMapper.selectPendingPurchaseCount",
            storeId
        );
    }


    // 미답변 문의 개수
    public int selectUnansweredInquiryCount(long storeId) {
        return sqlSession.selectOne(
            "ownerMapper.selectUnansweredInquiryCount",
            storeId
        );
    }


    // 재고 부족 TOP5
    public List<Map<String, Object>> selectShortageTop5(long storeId) {
        return sqlSession.selectList(
            "ownerMapper.selectShortageTop5",
            storeId
        );
    }


    // 오늘 입고 예정 목록
    public List<Map<String, Object>> selectTodayReceiptList(long storeId) {
        return sqlSession.selectList(
            "ownerMapper.selectTodayReceiptList",
            storeId
        );
    }


    // 미처리 발주 상태 목록
    public List<Map<String, Object>> selectPurchaseStatusList(long storeId) {
        return sqlSession.selectList(
            "ownerMapper.selectPurchaseStatusList",
            storeId
        );
    }


    // 오늘 마감 정보
    public Map<String, Object> selectTodayClosing(long storeId) {
        return sqlSession.selectOne(
            "ownerMapper.selectTodayClosing",
            storeId
        );
    }


    // 공지사항은 전체 공지라서 storeId 안 넘김
    public List<Map<String, Object>> selectNoticeList() {
        return sqlSession.selectList("ownerMapper.selectNoticeList");
    }
}
package com.kh.burgerstack.owner;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OwnerDashboardDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    public int selectShortageCount() {
        return sqlSession.selectOne("ownerMapper.selectShortageCount");
    }

    public int selectTodayReceiptCount() {
        return sqlSession.selectOne("ownerMapper.selectTodayReceiptCount");
    }

    public int selectPendingPurchaseCount() {
        return sqlSession.selectOne("ownerMapper.selectPendingPurchaseCount");
    }

    public int selectUnansweredInquiryCount() {
        return sqlSession.selectOne("ownerMapper.selectUnansweredInquiryCount");
    }

    public List<Map<String, Object>> selectShortageTop5() {
        return sqlSession.selectList("ownerMapper.selectShortageTop5");
    }

    public List<Map<String, Object>> selectTodayReceiptList() {
        return sqlSession.selectList("ownerMapper.selectTodayReceiptList");
    }

    public List<Map<String, Object>> selectPurchaseStatusList() {
        return sqlSession.selectList("ownerMapper.selectPurchaseStatusList");
    }

    public Map<String, Object> selectTodayClosing() {
        return sqlSession.selectOne("ownerMapper.selectTodayClosing");
    }

    public List<Map<String, Object>> selectNoticeList() {
        return sqlSession.selectList("ownerMapper.selectNoticeList");
    }
}
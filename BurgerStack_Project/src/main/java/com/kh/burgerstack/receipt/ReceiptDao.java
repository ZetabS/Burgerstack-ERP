package com.kh.burgerstack.receipt;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReceiptDao {

    public int getHistoryTotalCount(SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("ReceiptMapper.getHistoryTotalCount");
		// sqlSession.selectOne("count", condition);
	}

    public int getPlanTotalCount(SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("ReceiptMapper.getPlanTotalCount");
		// sqlSession.selectOne("count", condition);
	}

    public ArrayList<Receipt> searchReceiptPlanList(SqlSessionTemplate sqlSession){
        return (ArrayList)sqlSession.selectList("ReceiptMapper.searchReceiptPlanList");
    }

}

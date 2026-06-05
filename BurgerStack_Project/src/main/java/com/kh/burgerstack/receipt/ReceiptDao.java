package com.kh.burgerstack.receipt;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.purchase.PurchaseOrder;

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
    
    public List<PurchaseOrder> selectReceiptPlanList(
            SqlSessionTemplate sqlSession,
            PagingRequest pagingRequest) {

        return sqlSession.selectList(
                "ReceiptMapper.selectReceiptPlanList",
                null,
                new RowBounds(
                        pagingRequest.getOffset(),
                        pagingRequest.getLimit()
                )
        );
    }

}

package com.kh.burgerstack.receipt.model.dao;

import org.springframework.stereotype.Repository;

@Repository
public class ReceiptDao {

    public int getTotalCount() {
		return 123; // sqlSession.selectOne("count", condition);
	}

}

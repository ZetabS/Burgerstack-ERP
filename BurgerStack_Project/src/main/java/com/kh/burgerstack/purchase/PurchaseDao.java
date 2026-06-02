package com.kh.burgerstack.purchase;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PurchaseDao {

    public ArrayList<PurchaseRequest> searchMaterialsList(SqlSessionTemplate sqlSession) {

        return (ArrayList) sqlSession.selectList("com.kh.burgerstack.purchase.PurchaseMapper.searchMaterialsList");
    }
}

package com.kh.burgerstack.purchase;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.purchase.dto.MaterialInventoryDto;

@Repository
public class PurchaseDao {

    public ArrayList<MaterialInventoryDto> searchMaterialsList(SqlSessionTemplate sqlSession) {

        return (ArrayList) sqlSession.selectList("com.kh.burgerstack.purchase.PurchaseMapper.searchMaterialsList");
    }
}

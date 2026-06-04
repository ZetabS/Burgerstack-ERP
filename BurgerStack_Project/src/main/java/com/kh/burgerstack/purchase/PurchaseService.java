package com.kh.burgerstack.purchase;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PurchaseService {

    @Autowired
	private SqlSessionTemplate sqlSession;

    @Autowired
    private PurchaseDao purchaseDao;

    public ArrayList<PurchaseRequest> searchMaterialsList() {

        return purchaseDao.searchMaterialsList(sqlSession);

    }

}

package com.kh.burgerstack.receipt.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.burgerstack.common.pagination.model.dto.PageInfo;
import com.kh.burgerstack.common.pagination.model.dto.PagingRequest;

import com.kh.burgerstack.receipt.model.dao.ReceiptDao;
import com.kh.burgerstack.receipt.model.vo.Receipt;

@Service
public class ReceiptService {

    @Autowired
    private ReceiptDao receiptDao;

    @Autowired
	private SqlSessionTemplate sqlSession;

    public PageInfo getHistoryPageInfo(PagingRequest pagingRequest) {
        return pagingRequest.toPageInfo(receiptDao.getHistoryTotalCount(sqlSession));
    }

    public PageInfo getPlanPageInfo(PagingRequest pagingRequest) {
        return pagingRequest.toPageInfo(receiptDao.getPlanTotalCount(sqlSession));
    }

    public ArrayList<Receipt> searchReceiptPlanList() {

        return receiptDao.searchReceiptPlanList(sqlSession);
    }
}

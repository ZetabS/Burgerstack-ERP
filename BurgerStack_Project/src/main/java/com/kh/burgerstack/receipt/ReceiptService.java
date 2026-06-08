package com.kh.burgerstack.receipt;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.purchase.PurchaseOrder;

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

    
    
    public List<PurchaseOrder> selectReceiptPlanList(PagingRequest pagingRequest) {
        return receiptDao.selectReceiptPlanList(sqlSession, pagingRequest);
    }
    
    public List<Receipt> selectReceiptList() {
        return receiptDao.selectReceiptList();
    }
    
    
    
    
}








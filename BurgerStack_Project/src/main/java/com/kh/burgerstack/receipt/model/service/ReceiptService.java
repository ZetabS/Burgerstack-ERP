package com.kh.burgerstack.receipt.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.burgerstack.common.pagination.model.dto.PageInfo;
import com.kh.burgerstack.common.pagination.model.dto.PagingRequest;

import com.kh.burgerstack.receipt.model.dao.ReceiptDao;

@Service
public class ReceiptService {

    @Autowired
    private ReceiptDao receiptDao;

    public PageInfo getPageInfo(PagingRequest pagingRequest) {
        return pagingRequest.toPageInfo(receiptDao.getTotalCount());
    }
}

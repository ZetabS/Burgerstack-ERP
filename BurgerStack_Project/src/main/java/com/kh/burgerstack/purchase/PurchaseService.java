package com.kh.burgerstack.purchase;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.purchase.dto.MaterialInventoryDto;
import com.kh.burgerstack.purchase.dto.PurchaseDto;
import com.kh.burgerstack.purchase.dto.PurchaseRequestDto;
import com.kh.burgerstack.purchase.dto.PurchaseRequestItemDto;
import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpSession;

@Service
public class PurchaseService {

    @Autowired
	private SqlSessionTemplate sqlSession;

    @Autowired
    private PurchaseDao purchaseDao;

    public ArrayList<MaterialInventoryDto> searchMaterialsList(HttpSession session) {


    LoginUser loginUser =(LoginUser) session.getAttribute("loginUser");

        return purchaseDao.searchMaterialsList(
            sqlSession,
            loginUser.getStoreId()
        );
    }

    public ArrayList<PurchaseDto> searchPurchaseList() {
        return purchaseDao.searchPurchaseList(sqlSession);
    }

    @Transactional
    public void createPurchase(List<PurchaseRequestItemDto> items,
                            HttpSession session) {

        LoginUser user = (LoginUser) session.getAttribute("loginUser");

        // 1. total 계산
        long total = 0;

        for (PurchaseRequestItemDto item : items) {
            total += item.getUnitPriceSnapshot() * item.getRequestQuantity();
        }

        // 2. master 생성
        PurchaseRequestDto request = new PurchaseRequestDto();
        request.setStoreId(user.getStoreId());
        request.setCreatedBy(user.getUserId());
        request.setTotalAmount(total);
        request.setRequestMemo("자동 발주");

        purchaseDao.insertPurchaseRequest(request, sqlSession);

        Long requestId = request.getPurchaseRequestId();

        // 3. detail insert
        for (PurchaseRequestItemDto item : items) {
            item.setPurchaseRequestId(requestId);
            purchaseDao.insertPurchaseRequestItem(item, sqlSession);
        }
    }

}

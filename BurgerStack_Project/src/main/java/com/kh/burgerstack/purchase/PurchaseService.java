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
                            PurchaseRequestDto requestDto,
                            List<MaterialInventoryDto> materialList,
                            HttpSession session) {

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        requestDto.setStoreId(loginUser.getStoreId());   // ⭐ 핵심
        requestDto.setCreatedBy(loginUser.getUserId());
        requestDto.setRequestMemo("자동 발주");

        purchaseDao.insertPurchaseRequest(requestDto, sqlSession);                        

        // 1. 전체 금액 계산
        Long total = (long)0;

        for (int i = 0; i < items.size(); i++) {
            total += items.get(i).getUnitPriceSnapshot()
                    * items.get(i).getRequestQuantity();
        }

        requestDto.setTotalAmount(total);

        // 2. MASTER INSERT
        purchaseDao.insertPurchaseRequest(requestDto, sqlSession);

        Long requestId = requestDto.getPurchaseRequestId();

        // 3. DETAIL INSERT
        for (int i = 0; i < items.size(); i++) {

            PurchaseRequestItemDto item = items.get(i);

            item.setPurchaseRequestId(requestId);

            item.setMaterialNameSnapshot(materialList.get(i).getMaterialName());

            purchaseDao.insertPurchaseRequestItem(item, sqlSession);
        }
    }

}

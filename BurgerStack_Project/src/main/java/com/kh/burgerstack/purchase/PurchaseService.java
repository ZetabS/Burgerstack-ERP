package com.kh.burgerstack.purchase;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.purchase.dto.MaterialInventoryDto;
import com.kh.burgerstack.purchase.dto.PurchaseApprovalItemDto;
import com.kh.burgerstack.purchase.dto.PurchaseDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderDetailDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderItemDto;
import com.kh.burgerstack.purchase.dto.PurchaseSearchDto;
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

        return purchaseDao.searchMaterialsList(sqlSession,loginUser.getStoreId());
    }

    //발주 목록 조회
    public ArrayList<PurchaseDto> searchPurchaseList(
        PurchaseSearchDto condition, 
        HttpSession session) {

        // 로그인 세션 값 불러오기
        LoginUser loginUser =(LoginUser) session.getAttribute("loginUser");

        // 검색 조건 설정
        condition.setStoreId(loginUser.getStoreId());

        if (loginUser.getRole().equals("ADMIN")) {
            condition.setAdmin(true);
            return purchaseDao.searchPurchaseList(sqlSession, condition);
        }

        condition.setAdmin(false);
        return purchaseDao.searchPurchaseList(sqlSession, condition);
    }

    // 발주 요청 처리
    @Transactional
    public void createPurchase(List<PurchaseOrderItemDto> items,
                            HttpSession session) {

        LoginUser user = (LoginUser) session.getAttribute("loginUser");

        // System.out.println("user : " + session.getAttribute("loginUser"));

        // 1. total 계산
        long total = 0;

        for (PurchaseOrderItemDto item : items) {
            total += item.getSupplyPriceSnapshot() * item.getRequestQuantity();
        }

        // 2. master 생성
        PurchaseOrderDto request = new PurchaseOrderDto();
        request.setStoreId(user.getStoreId());
        request.setTotalAmount(total);
        request.setOrderMemo("수동 발주");

        purchaseDao.insertPurchaseOrder(request, sqlSession);

        Long purchaseOrderId = request.getPurchaseOrderId();

        // 3. detail insert
        for (PurchaseOrderItemDto item : items) {
            item.setPurchaseOrderId(purchaseOrderId);
            purchaseDao.insertPurchaseOrderItem(item, sqlSession);
        }
    }

    // 상세조회
    public List<PurchaseOrderDetailDto> getPurchaseOrderDetail(Long purchaseOrderId) {

        PurchaseDto purchase = purchaseDao.selectPurchase(purchaseOrderId, sqlSession);

        List<PurchaseOrderDetailDto> items =
                purchaseDao.selectPurchaseOrderDetail(purchaseOrderId, sqlSession);

        purchase.setItems(items);

        return purchaseDao.selectPurchaseOrderDetail(purchaseOrderId, sqlSession);
    }

    // 발주 수정
    public PurchaseDto getPurchaseForEdit(Long purchaseOrderId) {

        PurchaseDto purchase = purchaseDao.selectPurchase(purchaseOrderId, sqlSession);

        List<PurchaseOrderDetailDto> items =
                purchaseDao.selectPurchaseOrderDetail(purchaseOrderId, sqlSession);

        purchase.setItems(items);

        return purchase;
    }


    // 발주 수정 처리
    @Transactional
    public void updatePurchase(Long purchaseOrderId,
                            List<PurchaseOrderItemDto> items,
                            HttpSession session) {

        LoginUser user = (LoginUser) session.getAttribute("loginUser");

        
        if (user == null) {
            throw new RuntimeException("로그인 필요");
        }

        PurchaseDto origin = purchaseDao.selectPurchase(purchaseOrderId, sqlSession);
        
        // 1. total 계산
        long total = 0;

        for (PurchaseOrderItemDto item : items) {

            long price = item.getSupplyPriceSnapshot();
            long qty = item.getRequestQuantity();

            total += price * qty;
        }



        // 🔥 상태 체크 (REQUESTED만 수정 가능)
        if (!"REQUESTED".equals(origin.getStatus())) {
            throw new IllegalStateException("수정 불가 상태입니다.");
        }

        // 1. 기존 ITEM 삭제
        purchaseDao.deletePurchaseItems(purchaseOrderId, sqlSession);

        // 2. 새 ITEM 등록
        for (PurchaseOrderItemDto item : items) {
            item.setPurchaseOrderId(purchaseOrderId);
            purchaseDao.insertPurchaseOrderItem(item, sqlSession);
        }

         // TOTAL 재계산
        purchaseDao.updateTotalAmount(purchaseOrderId, sqlSession);
    }

    @Transactional
    public void cancelPurchase(Long purchaseOrderId, HttpSession session) {

        LoginUser user = (LoginUser) session.getAttribute("loginUser");

        PurchaseDto origin = purchaseDao.selectPurchase(purchaseOrderId, sqlSession);

        // 1. 이미 취소된 경우
        if ("CANCELED".equals(origin.getStatus())) {
            throw new IllegalStateException("이미 취소된 주문입니다.");
        }

        boolean isAdmin = "ADMIN".equals(user.getRole());

        // 2. 일반 유저는 REQUESTED만 가능
        if (!isAdmin && !"REQUESTED".equals(origin.getStatus())) {
            throw new IllegalStateException("취소 불가 상태입니다.");
        }

        // 3. 취소 처리
        purchaseDao.cancelPurchase(sqlSession, purchaseOrderId);
    }


    @Transactional
    public void processPurchase(
            Long purchaseOrderId,
            List<PurchaseApprovalItemDto> items) {

        boolean allApproved = true;
        boolean allRejected = true;

        for(PurchaseApprovalItemDto item : items){

            purchaseDao.updateApprovedQuantity(
                    purchaseOrderId,
                    item.getMaterialId(),
                    item.getApprovedQuantity(),
                    item.getRejectReason(),
                    sqlSession);

            if(item.getApprovedQuantity()
                    < item.getRequestQuantity()){

                allApproved = false;
            }

            if(item.getApprovedQuantity() > 0){
                allRejected = false;
            }
        }

        String status;

        if(allApproved){

            status = "APPROVED";

        }else if(allRejected){

            status = "REJECTED";

        }else{

            status = "PARTIALLY_APPROVED";
        }

        purchaseDao.updatePurchaseStatus(
                purchaseOrderId,
                status,
                sqlSession);
    }
}

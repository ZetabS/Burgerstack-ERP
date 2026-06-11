package com.kh.burgerstack.purchase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.dashboard.dto.AdminDashboardPurchaseOrderListItem;
import com.kh.burgerstack.dashboard.dto.PurchaseOrderStatistics;
import com.kh.burgerstack.purchase.dto.MaterialInventoryDto;
import com.kh.burgerstack.purchase.dto.PurchaseDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderDetailDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderItemDto;
import com.kh.burgerstack.purchase.dto.PurchaseSearchDto;

@Repository
public class PurchaseDao {
    @Autowired
    private PurchaseMapper purchaseMapper;

    // =========================
    // 자재 조회 (기존)
    // =========================
    public ArrayList<MaterialInventoryDto> searchMaterialsList(SqlSessionTemplate sqlSession, Long storeId) {

        return (ArrayList) sqlSession.selectList("com.kh.burgerstack.purchase.PurchaseMapper.searchMaterialsList", storeId);
    }

    public ArrayList<PurchaseDto> searchPurchaseList(PagingRequest pagingRequest, PurchaseSearchDto condition, SqlSessionTemplate sqlSession) {

    Map<String, Object> param = new HashMap<>();

    param.put("status", condition.getStatus());
    param.put("keyword", condition.getKeyword());
    param.put("startDate", condition.getStartDate());
    param.put("endDate", condition.getEndDate());
    param.put("storeId", condition.getStoreId());
    param.put("isAdmin", condition.isAdmin());

    param.put("startRow", pagingRequest.getStartRow());
    param.put("endRow", pagingRequest.getEndRow());


        return (ArrayList) sqlSession.selectList("com.kh.burgerstack.purchase.PurchaseMapper.searchPurchaseList", param);
    }

    public int selectPurchaseCount(PurchaseSearchDto condition, SqlSessionTemplate sqlSession){

        Map<String, Object> param = new HashMap<>();

        param.put("status", condition.getStatus());
        param.put("keyword", condition.getKeyword());
        param.put("startDate", condition.getStartDate());
        param.put("endDate", condition.getEndDate());
        param.put("storeId", condition.getStoreId());
        param.put("isAdmin", condition.isAdmin());

        return sqlSession.selectOne(
            "com.kh.burgerstack.purchase.PurchaseMapper.searchPurchaseCount",
            param);
    }

    // =========================
    // 발주 MASTER 생성
    // =========================
    public int insertPurchaseOrder(PurchaseOrderDto dto, SqlSessionTemplate sqlSession){

        return sqlSession.insert("com.kh.burgerstack.purchase.PurchaseMapper.insertPurchaseOrder", dto);
    }

    // =========================
    // 발주 DETAIL 생성
    // =========================
    public int insertPurchaseOrderItem(PurchaseOrderItemDto dto, SqlSessionTemplate sqlSession){

        return sqlSession.insert("com.kh.burgerstack.purchase.PurchaseMapper.insertPurchaseOrderItem", dto);
    }



    public List<PurchaseOrderDetailDto> selectPurchaseOrderDetail(Long purchaseOrderId, SqlSessionTemplate sqlSession) {
        return sqlSession.selectList(
            "com.kh.burgerstack.purchase.PurchaseMapper.selectPurchaseOrderDetail",
            purchaseOrderId
        );
    }

    public PurchaseDto selectPurchase(Long id, SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("com.kh.burgerstack.purchase.PurchaseMapper.selectPurchase", id);
    }

    public void deletePurchaseItems(Long id, SqlSessionTemplate sqlSession) {
        sqlSession.delete("com.kh.burgerstack.purchase.PurchaseMapper.deletePurchaseItems", id);
    }

    public void updateTotalAmount(Long id, SqlSessionTemplate sqlSession) {
        sqlSession.update("com.kh.burgerstack.purchase.PurchaseMapper.updateTotalAmount", id);
    }

    public int cancelPurchase(SqlSessionTemplate sqlSession, Long purchaseOrderId) {
        return sqlSession.update("com.kh.burgerstack.purchase.PurchaseMapper.cancelPurchase", purchaseOrderId);
    }

    public void updateApprovedQuantity(
            Long purchaseOrderId,
            int materialId,
            int approvedQuantity,
            String rejectReason,
            SqlSessionTemplate sqlSession) {

        Map<String, Object> param = new HashMap<>();

        param.put("purchaseOrderId", purchaseOrderId);
        param.put("materialId", materialId);
        param.put("approvedQuantity", approvedQuantity);
        param.put("rejectReason", rejectReason);

        sqlSession.update(
                "com.kh.burgerstack.purchase.PurchaseMapper.updateApprovedQuantity",
                param);
    }

    public void updatePurchaseStatus(
            Long purchaseOrderId,
            String status,
            SqlSessionTemplate sqlSession) {

        Map<String, Object> param = new HashMap<>();
        param.put("purchaseOrderId", purchaseOrderId);
        param.put("status", status);

        sqlSession.update(
                "com.kh.burgerstack.purchase.PurchaseMapper.updatePurchaseStatus",
                param);
    }

    public List<AdminDashboardPurchaseOrderListItem> findRecent(int count) {
        return purchaseMapper.findTopN(count);
    }

    public PurchaseOrderStatistics getPurchaseOrderStatistics() {
        return purchaseMapper.getPurchaseOrderStatistics();
    }
}


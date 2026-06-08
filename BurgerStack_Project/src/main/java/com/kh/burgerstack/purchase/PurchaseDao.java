package com.kh.burgerstack.purchase;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.purchase.dto.MaterialInventoryDto;
import com.kh.burgerstack.purchase.dto.PurchaseDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderDetailDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderItemDto;

@Repository
public class PurchaseDao {

    // =========================
    // 자재 조회 (기존)
    // =========================
    public ArrayList<MaterialInventoryDto> searchMaterialsList(SqlSessionTemplate sqlSession, Long storeId) {

        return (ArrayList) sqlSession.selectList("com.kh.burgerstack.purchase.PurchaseMapper.searchMaterialsList", storeId);
    }

    public ArrayList<PurchaseDto> searchPurchaseList(SqlSessionTemplate sqlSession) {

        return (ArrayList) sqlSession.selectList("com.kh.burgerstack.purchase.PurchaseMapper.searchPurchaseList");
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
}


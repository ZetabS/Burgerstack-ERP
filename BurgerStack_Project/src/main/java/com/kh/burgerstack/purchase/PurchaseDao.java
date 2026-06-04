package com.kh.burgerstack.purchase;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.purchase.dto.MaterialInventoryDto;
import com.kh.burgerstack.purchase.dto.PurchaseDto;
import com.kh.burgerstack.purchase.dto.PurchaseRequestDto;
import com.kh.burgerstack.purchase.dto.PurchaseRequestItemDto;

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
    public int insertPurchaseRequest(PurchaseRequestDto dto, SqlSessionTemplate sqlSession){

        return sqlSession.insert("com.kh.burgerstack.purchase.PurchaseMapper.insertPurchaseRequest", dto);
    }

    // =========================
    // 발주 DETAIL 생성
    // =========================
    public int insertPurchaseRequestItem(PurchaseRequestItemDto dto, SqlSessionTemplate sqlSession){

        return sqlSession.insert("com.kh.burgerstack.purchase.PurchaseMapper.insertPurchaseRequestItem", dto);
    }







}


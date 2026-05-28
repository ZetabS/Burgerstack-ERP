package com.kh.burgerstack.store.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.store.model.vo.Store;

@Repository
public class StoreDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    // 기존 점주 계정 확인
    public int checkOwner(String ownerId) {

        return sqlSession.selectOne(
                "storeMapper.checkOwner",
                ownerId
        );
    }

    // 점포 등록
    public int insertStore(Store store) {

        return sqlSession.insert(
                "storeMapper.insertStore", store
        );
    }

    // 전체 자재 기준 점포 재고 생성
    public int insertStoreStockMaterial(int storeNo) {

        return sqlSession.insert(
                "storeMapper.insertStoreStockMaterial",
                storeNo
        );
    }
}
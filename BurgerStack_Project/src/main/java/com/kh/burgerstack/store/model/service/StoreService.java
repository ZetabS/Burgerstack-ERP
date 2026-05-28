package com.kh.burgerstack.store.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.store.model.dao.StoreDao;
import com.kh.burgerstack.store.model.vo.Store;

@Service
public class StoreService {

    @Autowired
    private StoreDao storeDao;

    @Transactional
    public int insertStore(Store store, String createStockYn) {

        // 기존 점주 계정 존재 여부 확인
        int ownerCount = storeDao.checkOwner(store.getOwnerId());

        if(ownerCount == 0) {
            return 0;
        }

        // 점포 등록
        int result = storeDao.insertStore(store);

        // 전체 자재 기준 점포 재고 행 생성
        if(result > 0 && "Y".equals(createStockYn)) {

            storeDao.insertStoreStockMaterial(store.getStoreNo());
        }

        return result;
    }
}
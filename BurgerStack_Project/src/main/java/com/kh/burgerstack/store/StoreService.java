package com.kh.burgerstack.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.common.pagination.PagingRequest;

import com.kh.burgerstack.store.StoreListRow;

@Service
public class StoreService {

    @Autowired
    private StoreDao storeDao;

    @Autowired
    private SqlSession sqlSession;

    @Transactional
    public int insertStore(Store store, String createStockYn) {

        int result = storeDao.insertStore(store);

        return result;
    }


    // 점포 목록 조회
    public List<StoreListRow> selectStoreList(
            Map<String, String> map,
            PagingRequest pi) {

        return storeDao.selectStoreList(sqlSession, map, pi);
    }


    // 점포 개수 조회
    public int selectStoreCount(Map<String, String> map) {

        return storeDao.selectStoreCount(sqlSession, map);
    }

    // 점포 상세 조회
    public Store selectStoreDetail(Long storeId) {

        return storeDao.selectStoreDetail(storeId);
    }

    // 점포 수정
    public int updateStore(Store store) {

        return storeDao.updateStore(sqlSession, store);
    }

    // 점포 폐점 처리
    public int deleteStore(Long storeId) {

        return storeDao.deleteStore(sqlSession, storeId);
    }
    
    public Store selectStoreByOwnerUserNo(Long ownerUserNo) {

        return storeDao.selectStoreByOwnerUserNo(
                sqlSession,
                ownerUserNo
        );
    }
    
    public List<Store> selectOwnerStoreList(Long storeId) {
        return storeDao.selectOwnerStoreList(storeId);
    }
    
    public Map<String, Object> selectOwnerByLoginId(String keyword) {
        return storeDao.selectOwnerByLoginId(sqlSession, keyword);
    }

    public int countStoreName(String storeName) {
        return storeDao.countStoreName(sqlSession, storeName);
    }
    
    public int countStoreByOwnerUserNo(Long ownerUserNo) {
        return storeDao.countStoreByOwnerUserNo(sqlSession, ownerUserNo);
    }
    
}
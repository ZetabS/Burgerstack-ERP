package com.kh.burgerstack.store;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.common.pagination.PagingRequest;

import org.apache.ibatis.session.SqlSession;

@Service
public class StoreService {

    private final StoreDao storeDao;
    private final SqlSession sqlSession;

    @Transactional
    public int insertStore(Store store, String createStockYn) {

        // 기존 점주 계정 존재 여부 확인
        int ownerCount = storeDao.checkOwner(store.getOwnerUserId());

        if (ownerCount == 0) {
            return 0;
        }

        // 점포 등록
        int result = storeDao.insertStore(store);

        // 전체 자재 기준 점포 재고 행 생성
        if (result > 0 && "Y".equals(createStockYn)) {

            storeDao.insertStoreStockMaterial(store.getStoreId());
        }

        return result;
    }

    // 점포 목록 조회
    public List<StoreListRow> selectStoreList(
            Map<String, String> map, PagingRequest pi) {

        return storeDao.selectStoreList(
                sqlSession,
                map,
                pi);
    }

    // 점포 개수 조회
    public int selectStoreCount(
            Map<String, String> map) {

        return storeDao.selectStoreCount(
                sqlSession,
                map);

    }

    public StoreService(StoreDao storeDao, SqlSession sqlSession) {
        this.storeDao = storeDao;
        this.sqlSession = sqlSession;
    }

    public Store selectStoreDetail(Long storeId) {
        return storeDao.selectStoreDetail(storeId);
    }

    public StoreManagerView selectStoreManager(Long storeId) {
        return storeDao.selectStoreManager(storeId);
    }

    public int updateStore(Store store) {
        return storeDao.updateStore(sqlSession, store);
    }

    public int deleteStore(Long storeId) {
        return storeDao.deleteStore(sqlSession, storeId);
    }

}

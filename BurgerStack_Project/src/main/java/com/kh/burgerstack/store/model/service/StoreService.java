package com.kh.burgerstack.store.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.ibatis.session.SqlSession;
import com.kh.burgerstack.store.model.dao.StoreDao;
import com.kh.burgerstack.store.model.vo.Manager;
import com.kh.burgerstack.store.model.vo.SelectStoreList;
import com.kh.burgerstack.store.model.vo.Store;

@Service
public class StoreService {

	 private final StoreDao storeDao;
	 private final SqlSession sqlSession;

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
    
    
    // 점포 목록 조회
    public List<SelectStoreList> selectStoreList (
    							 Map<String, String>map){
    	
    	return storeDao.selectStoreList(
    			sqlSession,
    			map
    	);	
    }
    
    // 점포 개수 조회
    public int selectStoreCount (
    		   Map<String, String>map) {
   
    return storeDao.selectStoreCount(
    		sqlSession,
    		map
    );
    
    }  
    
    public StoreService (StoreDao storeDao, SqlSession sqlSession) {
    	this.storeDao = storeDao;
    	this.sqlSession = sqlSession;
    }
    
    public Store selectStoreDetail (int storeCode) {
    	return storeDao.selectStoreDetail(sqlSession, storeCode);
 
    }
 
    public Manager selectStoreManager (int storeCode) {
    	return (Manager) storeDao.selectStoreManager(sqlSession, storeCode);
 
    }
    
    public int updateStore(Store store) {
    	return storeDao.updateStore(sqlSession, store);
    }
    
    public int deleteStore(int storeCode) {
    	return storeDao.deleteStore(sqlSession, storeCode);
    }
    
    
    
    
}














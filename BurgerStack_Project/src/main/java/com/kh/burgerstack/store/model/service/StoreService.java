package com.kh.burgerstack.store.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.model.vo.PageInfo;
import com.kh.burgerstack.store.model.dao.StoreDao;
import com.kh.burgerstack.store.model.vo.Manager;
import com.kh.burgerstack.store.model.vo.SelectStoreList;
import com.kh.burgerstack.store.model.vo.Store;

@Service
public class StoreService {

    @Autowired
    private StoreDao storeDao;

    @Autowired
    private SqlSession sqlSession;

    @Transactional
    public int insertStore(Store store, String createStockYn) {

        int result = storeDao.insertStore(store);

       // if(result > 0 && "Y".equals(createStockYn)) {
         //   storeDao.insertStoreStockMaterial(store.getStoreCode());
        // }

        return result;
    }

    public List<SelectStoreList> selectStoreList(
            Map<String, String> map,
            PageInfo pi) {

        return storeDao.selectStoreList(sqlSession, map, pi);
    }

    public int selectStoreCount(Map<String, String> map) {

        return storeDao.selectStoreCount(sqlSession, map);
    }

    public Store selectStoreDetail(int storeCode) {
        return storeDao.selectStoreDetail(storeCode);
    }

    public Manager selectStoreManager(int storeCode) {
        return storeDao.selectStoreManager(storeCode);
    }

    public int updateStore(Store store) {
        return storeDao.updateStore(sqlSession, store);
    }

    public int deleteStore(int storeCode) {
        return storeDao.deleteStore(sqlSession, storeCode);
    }
}
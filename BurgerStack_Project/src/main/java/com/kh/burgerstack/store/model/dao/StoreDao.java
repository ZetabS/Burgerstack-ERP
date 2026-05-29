package com.kh.burgerstack.store.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.catalina.Manager;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.store.model.vo.SelectStoreList;
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
    
    // 점포 목록 조회
    public List<SelectStoreList> selectStoreList (
    		SqlSession sqlSession,
    		Map<String, String>map) {
    	
    	return sqlSession.selectOne(
    			"storeMapper.selectStoreList",map);
    }   
    
    // 점포 개수 조회
	public int selectStoreCount (
			SqlSession sqlSession,
			Map<String, String>map) {
		
		return sqlSession.selectOne(
				"storeMapper.selectStoreCount", map);
	}
	
	public Store selectStoreDetail(SqlSession sqlSession, int storeCode) {
		
		return sqlSession.selectOne("storeMapper.selectStoreDetail", storeCode);
	}
	
	public Manager selectStoreManager(SqlSession sqlSession, int storeCode) {
		
		return sqlSession.selectOne("storeMapper.selectStoreManager", storeCode);
	}
	
	public int updateStore(SqlSession sqlSession, Store store) {
		
		return sqlSession.update("storeMapper.updateStore", store);
	}
	
	public int deleteStore(SqlSession sqlSession, int storeCode) {
		
		return sqlSession.update("storeMapper.deleteStore", storeCode);
	}
	
	
	
	
	
	
	
	
	
	
}

	







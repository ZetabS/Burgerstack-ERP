package com.kh.burgerstack.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;

@Repository
public class StoreDao {
    @Autowired
    private StoreMapper storeMapper;

    @Autowired
    private SqlSessionTemplate sqlSession;

    // 기존 점주 계정 확인
    public int checkOwner(Long ownerUserId) {

        return sqlSession.selectOne(
                "storeMapper.checkOwner",
                ownerUserId);
    }

    // 점포 등록
    public int insertStore(Store store) {

        return sqlSession.insert(
                "storeMapper.insertStore", store);
    }

    // 전체 자재 기준 점포 재고 생성
    public int insertStoreStockMaterial(Long storeId) {

        return sqlSession.insert(
                "storeMapper.insertStoreStockMaterial",
                storeId);
    }

    // 점포 목록 조회
    public List<StoreListRow> selectStoreList(
            SqlSession sqlSession,
            Map<String, String> map, PagingRequest pi) {

        int offset = (pi.getPage() - 1)
                * pi.getLimit();

        // 페이지 처리 코드
        RowBounds rowBounds = new RowBounds(offset, pi.getLimit());

        return sqlSession.selectList(
                "storeMapper.selectStoreList",
                map,
                rowBounds);
    }

    // 점포 개수 조회
    public int selectStoreCount(
            SqlSession sqlSession,
            Map<String, String> map) {

        return sqlSession.selectOne(
                "storeMapper.selectStoreCount", map);
    }

    public Store selectStoreDetail(Long storeId) {
        return sqlSession.selectOne("storeMapper.selectStoreDetail", storeId);
    }

    public StoreManagerView selectStoreManager(Long storeId) {
        return sqlSession.selectOne("storeMapper.selectStoreManager", storeId);
    }

    public int updateStore(SqlSession sqlSession, Store store) {

        return sqlSession.update("storeMapper.updateStore", store);
    }

    public int deleteStore(SqlSession sqlSession, Long storeId) {

        return sqlSession.update("storeMapper.deleteStore", storeId);
    }

    public Long findStoreIdByOwnerUserId(Long OwnerUserId) {
        return storeMapper.findStoreIdByOwnerUserId(OwnerUserId);
    }
}

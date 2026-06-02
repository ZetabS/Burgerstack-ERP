package com.kh.burgerstack.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.model.vo.PageInfo;

@Repository
public class StoreDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    // 기존 점주 계정 확인
    public int checkOwner(String ownerId) {

        return sqlSession.selectOne(
                "storeMapper.checkOwner",
                ownerId);
    }

    // 점포 등록
    public int insertStore(Store store) {

        return sqlSession.insert(
                "storeMapper.insertStore", store);
    }

    // 전체 자재 기준 점포 재고 생성
    public int insertStoreStockMaterial(int storeNo) {

        return sqlSession.insert(
                "storeMapper.insertStoreStockMaterial",
                storeNo);
    }

    // 점포 목록 조회
    public List<SelectStoreList> selectStoreList(
            SqlSession sqlSession,
            Map<String, String> map, PageInfo pi) {

        int offset = (pi.getCurrentPage() - 1)
                * pi.getBoardLimit();

        // 페이지 처리 코드
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

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

    public Store selectStoreDetail(int storeCode) {
        return sqlSession.selectOne("storeMapper.selectStoreDetail", storeCode);
    }

    public Manager selectStoreManager(int storeCode) {
        return sqlSession.selectOne("storeMapper.selectStoreManager", storeCode);
    }

    public int updateStore(SqlSession sqlSession, Store store) {

        return sqlSession.update("storeMapper.updateStore", store);
    }

    public int deleteStore(SqlSession sqlSession, int storeCode) {

        return sqlSession.update("storeMapper.deleteStore", storeCode);
    }

}

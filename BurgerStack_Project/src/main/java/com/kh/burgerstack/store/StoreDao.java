package com.kh.burgerstack.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.store.StoreListRow;

@Repository
public class StoreDao {
    @Autowired
    private StoreMapper storeMapper;

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	// 점주 계정 확인
	public int checkOwner(Long ownerUserId) {
		return sqlSessionTemplate.selectOne("storeMapper.checkOwner", ownerUserId);
	}

	// 점포 등록
	public int insertStore(Store store) {
		return sqlSessionTemplate.insert("storeMapper.insertStore", store);
	}


	// 점포 개수 조회
	public int selectStoreCount(SqlSession sqlSession, Map<String, String> map) {
		return sqlSession.selectOne("storeMapper.selectStoreCount", map);
	}

	// 점포 상세 조회
	public Store selectStoreDetail(Long storeId) {
		return sqlSessionTemplate.selectOne("storeMapper.selectStoreDetail", storeId);
	}

	// 점포 목록 조회
	public List<StoreListRow> selectStoreList(SqlSession sqlSession, Map<String, String> map, PagingRequest pi) {
        int offset = (pi.getPage() - 1)
                * pi.getLimit();

        // 페이지 처리 코드
        RowBounds rowBounds = new RowBounds(offset, pi.getLimit());

		return sqlSession.selectList("storeMapper.selectStoreList", map, rowBounds);
	}

	// 점포 수정
	public int updateStore(SqlSession sqlSession, Store store) {

		return sqlSession.update("storeMapper.updateStore", store);
	}

	// 점포 폐점 처리
	public int deleteStore(SqlSession sqlSession, Long storeId) {

		return sqlSession.update("storeMapper.deleteStore", storeId);
	}
    public Long findStoreIdByOwnerUserId(Long OwnerUserId) {
        return storeMapper.findStoreIdByOwnerUserId(OwnerUserId);
    }

	public long findStoreIdByOwnerUserId(String userId) {
		
		return 0;
	}
}


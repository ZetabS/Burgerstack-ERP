package com.kh.burgerstack.closing;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ClosingDao {

	public List<StoreClosing> selectOwnerClosingList(SqlSession sqlSession,
													            Long storeId,
													            String startDate,
													            String endDate) {

			Map<String, Object> map = new HashMap<>();
			map.put("storeId", storeId);
			map.put("startDate", startDate);
			map.put("endDate", endDate);

			return sqlSession.selectList(
								"closingMapper.selectOwnerClosingList",
								map
					);
}
	
	public List<StoreClosing> selectAdminClosingList(SqlSession sqlSession,
											            Long storeId,
											            String startDate,
											            String endDate,
											            String keyword) {

			Map<String, Object> map = new HashMap<>();
			map.put("storeId", storeId);
			map.put("startDate", startDate);
			map.put("endDate", endDate);
			map.put("keyword", keyword);

			return sqlSession.selectList(
							"closingMapper.selectAdminClosingList",
								map
					);
}

    public List<StoreClosing> selectAdminClosingList(SqlSession sqlSession) {
        return sqlSession.selectList("closingMapper.selectAdminClosingList");
    }
    
    public StoreClosing selectClosing(SqlSession sqlSession, Long closingId) {
        return sqlSession.selectOne("closingMapper.selectClosing", closingId);
    }

    public List<StoreClosingItem> selectClosingItemList(SqlSession sqlSession, Long closingId) {
        return sqlSession.selectList("closingMapper.selectClosingItemList", closingId);
    }
    
    public List<ClosingInventory> selectClosingInventoryList(SqlSession sqlSession, Long storeId) {
        return sqlSession.selectList("closingMapper.selectClosingInventoryList", storeId);
    }
    
    public int insertClosing(SqlSession sqlSession, StoreClosing closing) {
        return sqlSession.insert("closingMapper.insertClosing", closing);
    }

    public int insertClosingItem(SqlSession sqlSession, StoreClosingItem item) {
        return sqlSession.insert("closingMapper.insertClosingItem", item);
    }
    
    public int updateInventoryQuantity(
            SqlSession sqlSession,
            Long storeInventoryId,
            Long quantity) {

        Map<String, Object> map = new HashMap<>();

        map.put("storeInventoryId", storeInventoryId);
        map.put("quantity", quantity);

        return sqlSession.update(
                "closingMapper.updateInventoryQuantity",
                map
        );
    }
    
    public List<StoreClosing> selectAdminClosingListByStoreId(SqlSession sqlSession, Long storeId) {
        return sqlSession.selectList("closingMapper.selectAdminClosingListByStoreId", storeId);
    }
    
    
    
    
    
    
    
}
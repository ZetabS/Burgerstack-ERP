package com.kh.burgerstack.closing;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ClosingService {

    private final ClosingDao closingDao;
    private final SqlSession sqlSession;

    public ClosingService(ClosingDao closingDao, SqlSession sqlSession) {
        this.closingDao = closingDao;
        this.sqlSession = sqlSession;
    }

    public List<StoreClosing> selectOwnerClosingList(Long storeId,
										            String startDate,
										            String endDate) {
		return closingDao.selectOwnerClosingList(
				sqlSession,
				storeId,
				startDate,
				endDate
		);
	}
    
    public List<StoreClosing> selectAdminClosingList(Long storeId,
										            String startDate,
										            String endDate,
										            String keyword) {
		return closingDao.selectAdminClosingList(
													sqlSession,
													storeId,
													startDate,
													endDate,
													keyword
);
}

    public List<StoreClosing> selectAdminClosingList() {
        return closingDao.selectAdminClosingList(sqlSession);
    }
    
    public StoreClosing selectClosing(Long closingId) {
        return closingDao.selectClosing(sqlSession, closingId);
    }

    public List<StoreClosingItem> selectClosingItemList(Long closingId) {
        return closingDao.selectClosingItemList(sqlSession, closingId);
    }
    
    public List<ClosingInventory> selectClosingInventoryList(Long storeId) {
        return closingDao.selectClosingInventoryList(sqlSession, storeId);
    }
    
    @Transactional
    public int insertClosing(StoreClosing closing, List<StoreClosingItem> itemList) {

        int result = closingDao.insertClosing(sqlSession, closing);

        for (StoreClosingItem item : itemList) {

            item.setStoreClosingId(
                    closing.getStoreClosingId()
            );

            Long systemQty = item.getSystemQuantity();
            Long useQty = item.getPhysicalQuantity();
            Long disposalQty = item.getDisposalQuantity();

            if (systemQty == null) {
                systemQty = 0L;
            }

            if (useQty == null) {
                useQty = 0L;
            }

            if (disposalQty == null) {
                disposalQty = 0L;
            }

            if (useQty + disposalQty > systemQty) {
                throw new IllegalArgumentException(
                        item.getMaterialNameSnapshot()
                        + "의 실사용수량과 폐기 수량의 합은 전산재고보다 클 수 없습니다."
                );
            }

            result += closingDao.insertClosingItem(
                    sqlSession,
                    item
            );

            Long finalQuantity =
                    systemQty - useQty - disposalQty;

            closingDao.updateInventoryQuantity(
                    sqlSession,
                    item.getStoreInventoryId(),
                    finalQuantity
            );
        }

        return result;
    }
    
    public List<StoreClosing> selectAdminClosingListByStoreId(Long storeId) {
        return closingDao.selectAdminClosingListByStoreId(sqlSession, storeId);
    }
    
    
}
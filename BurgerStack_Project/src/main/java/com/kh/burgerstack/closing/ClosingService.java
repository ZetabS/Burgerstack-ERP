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

    public List<StoreClosing> selectOwnerClosingList(Long storeId) {
        return closingDao.selectOwnerClosingList(sqlSession, storeId);
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

            result += closingDao.insertClosingItem(
                    sqlSession,
                    item
            );

            Long finalQuantity =
                    item.getSystemQuantity()
                    - item.getPhysicalQuantity()
                    - item.getDisposalQuantity();

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
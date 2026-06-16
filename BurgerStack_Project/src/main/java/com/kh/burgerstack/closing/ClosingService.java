package com.kh.burgerstack.closing;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.inventory.dto.InventoryChangeItem;
import com.kh.burgerstack.inventory.dto.InventoryStoreClosingChangeCommand;
import com.kh.burgerstack.inventory.service.InventoryService;
import com.kh.burgerstack.user.LoginUser;

@Service
public class ClosingService {
    private final InventoryService inventoryService;
    private final ClosingDao closingDao;
    private final SqlSession sqlSession;

    public ClosingService(ClosingDao closingDao, SqlSession sqlSession, InventoryService inventoryService) {
        this.closingDao = closingDao;
        this.sqlSession = sqlSession;
        this.inventoryService = inventoryService;
    }

    public List<StoreClosing> selectOwnerClosingList(Long storeId,
            String startDate,
            String endDate) {

	Map<String, Object> map = new HashMap<>();
	
	map.put("storeId", storeId);
	map.put("startDate", startDate);
	map.put("endDate", endDate);
	
	return closingDao.selectOwnerClosingList(sqlSession, map);
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
                keyword);
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
    public int insertClosing(StoreClosing closing, List<StoreClosingItem> itemList, LoginUser loginUser) {
        int result = closingDao.insertClosing(sqlSession, closing);

        for (StoreClosingItem item : itemList) {

            item.setStoreClosingId(
                    closing.getStoreClosingId());

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
                                + "의 실사용수량과 폐기 수량의 합은 전산재고보다 클 수 없습니다.");
            }

            result += closingDao.insertClosingItem(
                    sqlSession,
                    item);
        }

        List<InventoryChangeItem> inventoryChangeItems = itemList.stream()
                .map((StoreClosingItem item) -> {
                    int deltaQuantity = -item.getPhysicalQuantity().intValue() - item.getDisposalQuantity().intValue();
                    return new InventoryChangeItem(item.getStoreInventoryId().intValue(), deltaQuantity);
                }).filter((InventoryChangeItem item) -> item.getDeltaQuantity() != 0).toList();

        InventoryStoreClosingChangeCommand inventoryStoreClosingChangeCommand = new InventoryStoreClosingChangeCommand(
                loginUser,
                inventoryChangeItems,
                closing.getClosingMemo(),
                closing.getStoreClosingId().intValue(),
                loginUser.getStoreId().intValue());

        inventoryService.change(inventoryStoreClosingChangeCommand);
        return result;
    }

    public List<StoreClosing> selectAdminClosingListByStoreId(Long storeId) {
        return closingDao.selectAdminClosingListByStoreId(sqlSession, storeId);
    }

}
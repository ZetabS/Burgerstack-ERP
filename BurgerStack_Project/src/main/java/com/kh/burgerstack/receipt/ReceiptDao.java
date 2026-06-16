package com.kh.burgerstack.receipt;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.purchase.PurchaseOrder;

import java.util.HashMap;
import java.util.Map;

@Repository
public class ReceiptDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    public int getHistoryTotalCount(SqlSessionTemplate sqlSession,
						            String receiptType,
						            String startDate,
						            String endDate,
						            String keyword) {
						
		Map<String, Object> map = new HashMap<>();
		map.put("receiptType", receiptType);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("keyword", keyword);
						
		return sqlSession.selectOne(
		"ReceiptMapper.getHistoryTotalCount",
		map
);
}

    public List<Receipt> selectReceiptList(SqlSessionTemplate sqlSession,
								            PagingRequest pagingRequest,
								            String receiptType,
								            String startDate,
								            String endDate,
								            String keyword) {

			Map<String, Object> map = new HashMap<>();
			map.put("receiptType", receiptType);
			map.put("startDate", startDate);
			map.put("endDate", endDate);
			map.put("keyword", keyword);

			return sqlSession.selectList(
			"ReceiptMapper.selectReceiptList",
			map,
			new RowBounds(
			pagingRequest.getOffset(),
			pagingRequest.getLimit()
			)
		);
}
    
    public int getPlanTotalCount(SqlSessionTemplate sqlSession,
					            String status,
					            String startDate,
					            String endDate,
					            String keyword) {
					
					Map<String, Object> map = new HashMap<>();
					
					map.put("status", status);
					map.put("startDate", startDate);
					map.put("endDate", endDate);
					map.put("keyword", keyword);
					
					return sqlSession.selectOne(
					"ReceiptMapper.getPlanTotalCount",
					map
					);
					}

    public List<PurchaseOrder> selectReceiptPlanList(
            SqlSessionTemplate sqlSession,
            PagingRequest pagingRequest,
            String status,
            String startDate,
            String endDate,
            String keyword) {

        Map<String, Object> map = new HashMap<>();

        map.put("status", status);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        map.put("keyword", keyword);

        return sqlSession.selectList(
                "ReceiptMapper.selectReceiptPlanList",
                map,
                new RowBounds(
                        pagingRequest.getOffset(),
                        pagingRequest.getLimit()
                )
        );
    }

    
    
    public Long selectStoreIdByPurchaseOrderId(Long purchaseOrderId) {
        return sqlSession.selectOne("ReceiptMapper.selectStoreIdByPurchaseOrderId", purchaseOrderId);
    }

    public int insertReceipt(Receipt receipt) {
        return sqlSession.insert("ReceiptMapper.insertReceipt", receipt);
    }

    public int insertReceiptItem(ReceiptItem item) {
        return sqlSession.insert("ReceiptMapper.insertReceiptItem", item);
    }

    public int insertInventoryTransaction(ReceiptTransactionParam param) {
        return sqlSession.insert("ReceiptMapper.insertInventoryTransaction", param);
    }

    public Long selectCurrentQuantity(Long storeId, Long purchaseOrderItemId) {
        ReceiptInventoryParam param =
                new ReceiptInventoryParam(storeId, purchaseOrderItemId, 0L);

        Long result = sqlSession.selectOne("ReceiptMapper.selectCurrentQuantity", param);

        if (result == null) {
            return 0L;
        }

        return result;
    }

    public int increaseStoreInventory(ReceiptInventoryParam param) {
        return sqlSession.update("ReceiptMapper.increaseStoreInventory", param);
    }

    public Long selectStoreInventoryId(Long storeId, Long purchaseOrderItemId) {
        ReceiptInventoryParam param =
                new ReceiptInventoryParam(storeId, purchaseOrderItemId, 0L);

        return sqlSession.selectOne("ReceiptMapper.selectStoreInventoryId", param);
    }

    public int insertInventoryTransactionItem(ReceiptTransactionItemParam param) {
        return sqlSession.insert("ReceiptMapper.insertInventoryTransactionItem", param);
    }

    public int updatePurchaseOrderStatus(Long purchaseOrderId) {
        return sqlSession.update("ReceiptMapper.updatePurchaseOrderStatus", purchaseOrderId);
    }
    
    
    public Receipt selectReceiptDetail(Long receiptId) {
        return sqlSession.selectOne("ReceiptMapper.selectReceiptDetail", receiptId);
    }

    public List<ReceiptItemDetail> selectReceiptItemDetailList(Long receiptId) {
        return sqlSession.selectList("ReceiptMapper.selectReceiptItemDetailList", receiptId);
    }
    
    public List<ReceiptCheckItemDto> selectReceiptCheckItemList(Long purchaseId) {
        return sqlSession.selectList("ReceiptMapper.selectReceiptCheckItemList", purchaseId);
    }
    
    public String selectPurchaseStatus(Long purchaseId) {
        return sqlSession.selectOne(
                "ReceiptMapper.selectPurchaseStatus",
                purchaseId
        );
    }
    
}
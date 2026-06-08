package com.kh.burgerstack.inventory.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.exception.CustomException;
import com.kh.burgerstack.inventory.dto.InventoryTransactionDetail;
import com.kh.burgerstack.inventory.dto.InventoryTransactionDetailItem;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListItem;
import com.kh.burgerstack.inventory.dto.InventoryTransactionSearchCondition;
import com.kh.burgerstack.inventory.vo.InventoryTransaction;
import com.kh.burgerstack.inventory.vo.InventoryTransactionItem;
import com.kh.burgerstack.user.LoginUser;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InventoryTransactionDao {
    private final InventoryTransactionMapper inventoryTransactionMapper;

    public InventoryTransaction insert(InventoryTransaction inventoryTransaction) {
        int result = inventoryTransactionMapper.insert(inventoryTransaction);
        if (result <= 0) {
            throw new CustomException("재고 변동 이력을 추가할 수 없습니다.");
        }
        return inventoryTransactionMapper.findById(inventoryTransaction.getInventoryTransactionId());
    }

    public InventoryTransaction findById(int inventoryTransactionId) {
        return inventoryTransactionMapper.findById(inventoryTransactionId);
    }

    public List<InventoryTransactionItem> findItemsByTransactionId(
            int inventoryTransactionId) {
        return inventoryTransactionMapper.findItemsByTransactionId(inventoryTransactionId);
    }

    public List<InventoryTransactionItem> insertItems(
            int inventoryTransactionId,
            List<InventoryTransactionItem> list) {
        int result = inventoryTransactionMapper.insertItems(inventoryTransactionId, list);
        if (result <= 0) {
            throw new CustomException("재고 변동 이력을 추가할 수 없습니다.");
        }
        return inventoryTransactionMapper.findItemsByTransactionId(inventoryTransactionId);
    }

    public List<InventoryTransactionListItem> findInventoryTransactionListItems(
            InventoryTransactionSearchCondition condition,
            PagingRequest pagingRequest,
            LoginUser loginUser) {
        return inventoryTransactionMapper.findInventoryTransactionListItems(condition, pagingRequest);
    }

    public int count(InventoryTransactionSearchCondition condition) {
        return inventoryTransactionMapper.count(condition);
    }

    public InventoryTransactionDetail getInventoryTransactionDetailById(int inventoryTransactionId) {
        return inventoryTransactionMapper.getInventoryTransactionDetailById(inventoryTransactionId);
    }

    public List<InventoryTransactionDetailItem> findInventoryTransactionDetailItems(int inventoryTransactionId) {
        return inventoryTransactionMapper.findInventoryTransactionDetailItems(inventoryTransactionId);
    }
}

package com.kh.burgerstack.inventory.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.exception.BusinessException;
import com.kh.burgerstack.inventory.domain.InventoryTransaction;
import com.kh.burgerstack.inventory.domain.InventoryTransactionItem;
import com.kh.burgerstack.inventory.dto.InventoryTransactionDetailViewModel;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListViewModel;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListCondition;
import com.kh.burgerstack.user.LoginUser;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InventoryTransactionDao {
    private final InventoryTransactionMapper inventoryTransactionMapper;

    public InventoryTransaction insert(InventoryTransaction inventoryTransaction) {
        int result = inventoryTransactionMapper.insert(inventoryTransaction);
        if (result <= 0) {
            throw new BusinessException("재고 변동 이력을 추가할 수 없습니다.");
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

    public InventoryTransactionItem insertItem(
            InventoryTransactionItem item) {
        int result = inventoryTransactionMapper.insertItem(item);
        if (result <= 0) {
            throw new BusinessException("재고 변동 이력을 추가할 수 없습니다.");
        }
        return inventoryTransactionMapper.findItemById(item.getInventoryTransactionItemId());
    }

    public List<InventoryTransactionListViewModel.Item> findInventoryTransactionListItems(
            InventoryTransactionListCondition condition,
            PagingRequest pagingRequest,
            LoginUser loginUser) {
        return inventoryTransactionMapper.findInventoryTransactionListItems(condition, pagingRequest);
    }

    public int count(InventoryTransactionListCondition condition) {
        return inventoryTransactionMapper.count(condition);
    }

    public InventoryTransactionDetailViewModel getInventoryTransactionDetailById(int inventoryTransactionId) {
        return inventoryTransactionMapper.getInventoryTransactionDetailById(inventoryTransactionId);
    }

    public List<InventoryTransactionDetailViewModel.Item> findInventoryTransactionDetailItems(
            int inventoryTransactionId) {
        return inventoryTransactionMapper.findInventoryTransactionDetailItems(inventoryTransactionId);
    }
}

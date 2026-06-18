package com.kh.burgerstack.inventory.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.domain.InventoryTransaction;
import com.kh.burgerstack.inventory.domain.InventoryTransactionItem;
import com.kh.burgerstack.inventory.dto.InventoryTransactionDetailViewModel;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListViewModel;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListCondition;

@Mapper
public interface InventoryTransactionMapper {
    public int insert(InventoryTransaction inventoryTransaction);

    public InventoryTransaction findById(
            @Param("inventoryTransactionId") int inventoryTransactionId);

    public InventoryTransactionItem findItemById(
            @Param("inventoryTransactionItemId") int inventoryTransactionItemId);

    public int insertItem(
            @Param("item") InventoryTransactionItem item);

    public List<InventoryTransactionItem> findItemsByTransactionId(
            @Param("inventoryTransactionId") int inventoryTransactionId);

    public List<InventoryTransactionListViewModel.Item> findInventoryTransactionListItems(
            @Param("condition") InventoryTransactionListCondition condition,
            @Param("paging") PagingRequest paging);

    public int count(
            @Param("condition") InventoryTransactionListCondition condition);

    public InventoryTransactionDetailViewModel getInventoryTransactionDetailById(
            @Param("inventoryTransactionId") int inventoryTransactionId);

    public List<InventoryTransactionDetailViewModel.Item> findInventoryTransactionDetailItems(
            @Param("inventoryTransactionId") int inventoryTransactionId);
}

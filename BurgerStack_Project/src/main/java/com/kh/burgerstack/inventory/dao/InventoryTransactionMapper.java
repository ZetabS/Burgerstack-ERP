package com.kh.burgerstack.inventory.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventoryTransactionDetail;
import com.kh.burgerstack.inventory.dto.InventoryTransactionDetailItem;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListItem;
import com.kh.burgerstack.inventory.dto.InventoryTransactionSearchCondition;
import com.kh.burgerstack.inventory.vo.InventoryTransaction;
import com.kh.burgerstack.inventory.vo.InventoryTransactionItem;

@Mapper
public interface InventoryTransactionMapper {
    public int insert(InventoryTransaction inventoryTransaction);

    public InventoryTransaction findById(
            @Param("inventoryTransactionId") int inventoryTransactionId);

    public InventoryTransactionItem findItemById(
            @Param("inventoryTransactionItemId") int inventoryTransactionItemId);

    public int insertItem(
            @Param("inventoryTransactionId") int inventoryTransactionId,
            @Param("item") InventoryTransactionItem item);

    public List<InventoryTransactionItem> findItemsByTransactionId(
            @Param("inventoryTransactionId") int inventoryTransactionId);

    public List<InventoryTransactionListItem> findInventoryTransactionListItems(
            @Param("condition") InventoryTransactionSearchCondition condition,
            @Param("paging") PagingRequest paging);

    public int count(
            @Param("condition") InventoryTransactionSearchCondition condition);

    public InventoryTransactionDetail getInventoryTransactionDetailById(
            @Param("inventoryTransactionId") int inventoryTransactionId);

    public List<InventoryTransactionDetailItem> findInventoryTransactionDetailItems(
            @Param("inventoryTransactionId") int inventoryTransactionId);
}

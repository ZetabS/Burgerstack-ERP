package com.kh.burgerstack.inventory.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.burgerstack.inventory.vo.InventoryTransaction;
import com.kh.burgerstack.inventory.vo.InventoryTransactionItem;

@Mapper
public interface InventoryTransactionMapper {
    public int insert(InventoryTransaction inventoryTransaction);

    public InventoryTransaction findById(
            @Param("inventoryTransactionId") int inventoryTransactionId);

    public int insertItems(
            @Param("inventoryTransactionId") int inventoryTransactionId,
            @Param("list") List<InventoryTransactionItem> list);

    public List<InventoryTransactionItem> findItemsByTransactionId(
            @Param("inventoryTransactionId") int inventoryTransactionId);

}

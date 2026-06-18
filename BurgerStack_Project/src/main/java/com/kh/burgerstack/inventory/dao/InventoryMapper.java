package com.kh.burgerstack.inventory.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.domain.StoreInventory;
import com.kh.burgerstack.inventory.dto.InventoryDetailViewModel;
import com.kh.burgerstack.inventory.dto.InventoryListCondition;
import com.kh.burgerstack.inventory.dto.InventoryListViewModel;

@Mapper
public interface InventoryMapper {
    public StoreInventory findById(
            @Param("storeInventoryId") int storeInventoryId);

    public List<InventoryListViewModel.Item> findInventoryListItems(
            @Param("condition") InventoryListCondition condition,
            @Param("paging") PagingRequest pagingRequest);

    public int count(
            @Param("condition") InventoryListCondition condition);

    public InventoryDetailViewModel getInventoryDetailById(
            @Param("storeInventoryId") int storeInventoryId);

    public int update(
            @Param("inventory") StoreInventory inventory);
}

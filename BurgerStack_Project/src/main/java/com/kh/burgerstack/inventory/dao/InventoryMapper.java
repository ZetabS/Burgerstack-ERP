package com.kh.burgerstack.inventory.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventoryChangeParam;
import com.kh.burgerstack.inventory.dto.InventoryDetail;
import com.kh.burgerstack.inventory.dto.InventoryListItem;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;
import com.kh.burgerstack.inventory.vo.StoreInventory;

@Mapper
public interface InventoryMapper {

    public List<InventoryListItem> findInventoryListItems(
            @Param("condition") InventorySearchCondition condition,
            @Param("paging") PagingRequest pagingRequest);

    public int count(
            @Param("condition") InventorySearchCondition condition);

    public InventoryDetail getInventoryDetailById(
            @Param("storeInventoryId") int storeInventoryId);

    public int updateQuantity(
            @Param("param") InventoryChangeParam param);

    public StoreInventory findById(
            @Param("storeInventoryId") int storeInventoryId);

    public int updateSafetyQuantity(
            @Param("storeInventoryId") int storeInventoryId,
            @Param("safetyQuantity") int safetyQuantity,
            @Param("currentSafetyQuantity") int currentSafetyQuantity);
}

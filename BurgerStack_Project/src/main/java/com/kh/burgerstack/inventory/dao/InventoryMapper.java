package com.kh.burgerstack.inventory.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventoryDetail;
import com.kh.burgerstack.inventory.dto.InventoryListItem;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;

@Mapper
public interface InventoryMapper {

    public ArrayList<InventoryListItem> findInventoryListItems(
            @Param("condition") InventorySearchCondition condition,
            @Param("paging") PagingRequest pagingRequest);

    public int count(@Param("condition") InventorySearchCondition condition);

    public InventoryDetail getInventoryDetailById(@Param("storeInventoryId") int storeInventoryId);
}

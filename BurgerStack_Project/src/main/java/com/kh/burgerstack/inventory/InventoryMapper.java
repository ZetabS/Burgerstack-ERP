package com.kh.burgerstack.inventory;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;

@Mapper
public interface InventoryMapper {

    ArrayList<StoreInventory> findInventoryListItems(
            @Param("condition") InventorySearchCondition condition,
            @Param("paging") PagingRequest pagingRequest);

    int count();
}

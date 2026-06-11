package com.kh.burgerstack.store;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.burgerstack.dashboard.dto.StoreStatistics;
import com.kh.burgerstack.store.dto.StoreOption;

@Mapper
public interface StoreMapper {
    public Long findStoreIdByOwnerUserNo(Long ownerUserNo);

	public Long findStoreIdByOwnerUserId(Long ownerUserId);
    public List<StoreOption> getStoreOptions();

    public StoreStatistics getStoreStatistics();
}

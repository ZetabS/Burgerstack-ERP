package com.kh.burgerstack.store;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StoreMapper {
    public Long findStoreIdByOwnerUserNo(Long ownerUserNo);

	public Long findStoreIdByOwnerUserId(Long ownerUserId);
}

package com.kh.burgerstack.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {

	public LoginUser login(String loginId);

	public int insertStoreOwner(User u);
	
}

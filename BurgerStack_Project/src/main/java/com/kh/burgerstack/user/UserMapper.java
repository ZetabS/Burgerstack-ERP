package com.kh.burgerstack.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {

	public LoginUser login(String userId);
	
	public int update(User u);

	public int updatePassword(User u);

	public int NewOwner(User u);
}

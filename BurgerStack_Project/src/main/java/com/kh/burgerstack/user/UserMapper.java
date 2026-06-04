package com.kh.burgerstack.user;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionTemplate;

@Mapper
public interface UserMapper {

	public LoginUser login(String loginId);

	public int insertStoreOwner(User u);
	
	public int update(SqlSessionTemplate session,User u);
}

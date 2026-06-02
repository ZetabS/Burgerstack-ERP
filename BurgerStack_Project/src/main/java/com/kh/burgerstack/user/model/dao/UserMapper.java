package com.kh.burgerstack.user.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.burgerstack.user.model.vo.LoginUser;

@Mapper
public interface UserMapper {

	public LoginUser login(String loginId);
	
	

}

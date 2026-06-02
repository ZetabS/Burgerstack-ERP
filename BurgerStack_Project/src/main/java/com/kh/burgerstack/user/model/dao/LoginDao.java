package com.kh.burgerstack.user.model.dao;

import org.springframework.stereotype.Repository;

import com.kh.burgerstack.user.model.vo.LoginUser;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class LoginDao {
	
	private final UserMapper userMapper;

	public LoginUser login(String loginId) {
		return userMapper.login(loginId);
	}
}

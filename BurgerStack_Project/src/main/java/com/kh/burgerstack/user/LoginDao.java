package com.kh.burgerstack.user;

import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class LoginDao {
	
	private final UserMapper userMapper;

	public LoginUser login(String userId) {
		return userMapper.login(userId);
	}
}

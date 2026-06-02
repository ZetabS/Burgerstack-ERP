package com.kh.burgerstack.user;

import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserDao {

	private final UserMapper userMapper;
	
	public int insertStoreOwner(User u) {
		
		return userMapper.insertStoreOwner(u);
	}

}

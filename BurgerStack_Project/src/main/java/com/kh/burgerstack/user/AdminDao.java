package com.kh.burgerstack.user;

import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AdminDao {

	private final UserMapper userMapper;
	
	public int update(User u) {
		return userMapper.update(u);
	}

	public int updatePassword(User u) {
		return userMapper.updatePassword(u);
	}
	public int NewOwner(User u) {
		return userMapper.NewOwner(u);
	}


}

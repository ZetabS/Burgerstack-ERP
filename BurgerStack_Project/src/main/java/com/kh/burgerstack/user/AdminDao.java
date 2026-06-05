package com.kh.burgerstack.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AdminDao {

	@Autowired
	private UserMapper userMapper;
	
	public int update(User u) {
		return userMapper.update(u);
	}

	public int updatePassword(User u) {
		return userMapper.updatePassword(u);
	}

}

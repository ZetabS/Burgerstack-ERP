package com.kh.burgerstack.user;

import java.util.List;

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

	public List<User> OwnerList() {
		return userMapper.OwnerList();
	}

	public User OwnerListDetail(String userId) {
		return userMapper.OwnerListDetail(userId);
	}

	public int OwnerStatus(User u) {
		return userMapper.OwnerStatus(u);
	}

	public int OwnerUpdate(User user) {
		return userMapper.OwnerUpdate(user);
	}



}

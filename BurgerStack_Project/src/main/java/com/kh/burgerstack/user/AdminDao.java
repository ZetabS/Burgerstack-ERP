package com.kh.burgerstack.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;

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

	public List<User> OwnerList(String status, String keyword, PagingRequest pi) {

	    Map<String, Object> param = new HashMap<>();

	    param.put("status", status);
	    param.put("keyword", keyword);

	    int currentPage = pi.getPage(); 
	    int size = 10; 
	    int startRow = (currentPage - 1) * size + 1;
	    int endRow = currentPage * size;

	    param.put("startRow", startRow);
	    param.put("endRow", endRow);

	    return userMapper.OwnerList(param);
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

	public int getOwnerCount(String status, String keyword) {
		
	Map<String, String> param = new HashMap<>();
	param.put("status", status);
	param.put("keyword", keyword);
		
	return userMapper.getOwnerCount(param);
	}



}

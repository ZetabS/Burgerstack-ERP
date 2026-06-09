package com.kh.burgerstack.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {

	public LoginUser login(String userId);
	
	public int update(User u);

	public int updatePassword(User u);

	public int NewOwner(User u);

	public List<User> OwnerList();

	public User OwnerListDetail(String userId);

	public int OwnerStatus(User u);

	public int OwnerUpdate(User user);
}

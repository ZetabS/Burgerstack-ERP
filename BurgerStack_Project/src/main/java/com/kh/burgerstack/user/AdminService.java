package com.kh.burgerstack.user;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService {

	private final AdminDao adminDao;
	
	public int update(User u) {
		
		return adminDao.update(u);
	}

	public int updatePassword(User u) {
		
		return adminDao.updatePassword(u);
	}

	public int NewOwner(User u) {
		
		return adminDao.NewOwner(u);
		
	
	}

	public List<User> OwnerList(String status,
            String keyword) {

		return adminDao.OwnerList(status, keyword);
	}

	public User OwnerListDetail(String userId) {
		return adminDao.OwnerListDetail(userId);
	}

	public int OwnerStatus(User u) {
		return adminDao.OwnerStatus(u);
	}

}

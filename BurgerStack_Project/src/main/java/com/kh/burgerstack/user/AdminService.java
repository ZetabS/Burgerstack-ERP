package com.kh.burgerstack.user;

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

}

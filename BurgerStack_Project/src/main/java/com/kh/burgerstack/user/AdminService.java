package com.kh.burgerstack.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService {

	@Autowired
	private AdminDao adminDao;
	
	public int update(User u) {
		
		return adminDao.update(u);
	}

	public int updatePassword(User u) {
		
		return adminDao.updatePassword(u);
	}

}

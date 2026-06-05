package com.kh.burgerstack.user;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OwnerService {
	
	private OwnerDao ownerDao;
	
	public int update(User u) {
		
		return ownerDao.update(u);
	}

	public int updatePassword(User u) {
		
		return ownerDao.updatePassword(u);
	}

}

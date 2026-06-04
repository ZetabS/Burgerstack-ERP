package com.kh.burgerstack.user;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OwnerService {
	
	private OwnerDao ownerDao;
	
	public int update(SqlSessionTemplate session, User u) {
		
		return ownerDao.update(sqlSession.u);
	}

}

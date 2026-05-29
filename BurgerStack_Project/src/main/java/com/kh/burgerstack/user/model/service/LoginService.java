package com.kh.burgerstack.user.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.burgerstack.user.model.dao.LoginDao;
import com.kh.burgerstack.user.model.vo.User;

@Service
public class LoginService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private LoginDao memberDao;
	
	public User loginUser(User u) {
		
		return memberDao.loginUser(sqlSession, u);
	}
	
}

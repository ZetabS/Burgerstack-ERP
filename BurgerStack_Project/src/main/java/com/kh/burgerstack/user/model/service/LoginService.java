package com.kh.burgerstack.user.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.burgerstack.user.model.dao.LoginDao;
import com.kh.burgerstack.user.model.vo.LoginUser;

@Service
public class LoginService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private LoginDao loginDao;

	public LoginUser login(String loginId) {
		
		return loginDao.login(loginId);
		
	}	
}

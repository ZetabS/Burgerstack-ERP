package com.kh.burgerstack.user;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

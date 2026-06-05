package com.kh.burgerstack.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

	@Autowired
	private LoginDao loginDao;

	public LoginUser login(String userId) {

		return loginDao.login(userId);

	}
}

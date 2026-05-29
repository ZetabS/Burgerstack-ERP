package com.kh.burgerstack.user.model.dao;

import org.springframework.stereotype.Repository;

import com.kh.burgerstack.user.model.vo.User;

@Repository
public class LoginDao {

	public User loginUser(SqlSessionTemplate sqlSesion, User u);
	
	return sqlSession.selectOne();

}

package com.kh.burgerstack.user;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class OwnerDao {
	
	private UserMapper userMapper;
	
	public int update(SqlSessionTemplate sqlSession, User u) {
		
		return sqlSession.update(userMapper.update, u);
	}

}

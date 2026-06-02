package com.kh.burgerstack.material.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.material.model.vo.Material;

@Repository
public class MaterialDao {

	public void materialInsert() {
		
	} //materialInsert

	public int materialInsert(SqlSessionTemplate sqlSession, Material m) {
		
		return 1;
	}
}

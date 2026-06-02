package com.kh.burgerstack.material.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.material.model.dao.MaterialDao;
import com.kh.burgerstack.material.model.vo.Material;

@Service
public class MaterialSerivce {

	@Autowired
	private MaterialDao materialDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Transactional
	public int materialInsert(Material m) {
		
		return materialDao.materialInsert(sqlSession, m);
	} //materialInsert
	
	
}

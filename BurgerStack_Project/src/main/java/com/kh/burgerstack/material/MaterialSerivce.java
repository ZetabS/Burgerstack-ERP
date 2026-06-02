package com.kh.burgerstack.material;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

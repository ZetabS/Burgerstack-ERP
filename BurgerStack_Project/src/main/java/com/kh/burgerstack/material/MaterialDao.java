package com.kh.burgerstack.material;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MaterialDao {

	@Autowired
	private MaterialMapper materialMapper;
	
	public int filesInsert() {
		return 1;
	} //materialInsert

	public int materialInsert(Material m) {
		return materialMapper.insert(m);
	} //materialInsert
}

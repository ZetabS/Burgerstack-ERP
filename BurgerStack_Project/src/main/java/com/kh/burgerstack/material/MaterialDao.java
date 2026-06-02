package com.kh.burgerstack.material;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MaterialDao {

	public void materialInsert() {

	} //materialInsert

	public int materialInsert(SqlSessionTemplate sqlSession, Material m) {

		return 1;
	}
}

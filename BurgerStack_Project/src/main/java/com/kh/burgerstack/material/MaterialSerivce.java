package com.kh.burgerstack.material;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.file.FileStore;

@Service
public class MaterialSerivce {

	@Autowired
	private MaterialDao materialDao;
	@Autowired
	private FileStore fileStore;
	
	@Transactional
	public int materialInsert(Material m/*StoredFile sf*/) {
		
		// 1. FILES DB 등록
//		int result1 = maaterialDao.filesInsert();
		int result1 = 1;
//		result1 = materialDao.filesInsert(f);
		// 2. MATERIALS DB 등록
		
		int result2 = materialDao.materialInsert(m);
		
		return result1 * result2;
	} //materialInsert
	
	
}

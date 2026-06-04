package com.kh.burgerstack.material;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MaterialDao {

	@Autowired
	private MaterialMapper materialMapper;

	public int materialInsert(Material m) {
		return materialMapper.insert(m);
	} //materialInsert
	
	public ArrayList<Material> selectMaterialList() {
		return materialMapper.selectMaterialList();
	} //selectMaterialList

	public Material materialDetail(Long materialId) {
		return materialMapper.materialDetail(materialId);
	} //materialDetail
	
	public int updateMaterial(Material m) {
		return materialMapper.updateMaterial(m);
	}
	
	public Material selectMaterial(Long finalMaterialId) {
		return materialMapper.selectMaterial(finalMaterialId);
	}
	
	public int deleteMaterial(Long materialId) {
		return materialMapper.deleteMaterial(materialId);
	}
}

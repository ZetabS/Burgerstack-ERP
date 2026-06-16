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
    }
    
    public int insertInventoryStores(Long materialId) {
		return materialMapper.insertInventoryStores(materialId);
	}

    public int materialFileInsert(MaterialFile materialFile) {
        return materialMapper.materialFileInsert(materialFile);
    }

    public ArrayList<Material> selectMaterialList(String materialType, String keyword) {
        return materialMapper.selectMaterialList(materialType, keyword);
    }

    public String materialDetail(Long materialId) {
        return materialMapper.materialDetail(materialId);
    }

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

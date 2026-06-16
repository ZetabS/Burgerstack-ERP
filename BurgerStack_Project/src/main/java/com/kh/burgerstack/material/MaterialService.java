package com.kh.burgerstack.material;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.burgerstack.file.FileStore;
import com.kh.burgerstack.file.StoredFile;

@Service
public class MaterialService {

    @Autowired
    private MaterialDao materialDao;
    
    @Autowired
    private FileStore fileStore;
/*
    @Transactional
    public int materialInsert(Material m) {
        return materialDao.materialInsert(m);
    }
*/
    @Transactional
    public void materialInsert(Material m, MultipartFile imageFile) {
        // 자재 등록
        materialDao.materialInsert(m);
        // 재고 초기화
        materialDao.insertInventoryStores(m.getMaterialId());
        // 파일 저장
        if (imageFile != null && !imageFile.isEmpty()) {
            StoredFile storedFile = fileStore.store(imageFile, "material_upfiles");
            materialDao.materialFileInsert(storedFile.toMaterialFile(m.getMaterialId()));
        }
    }

    public ArrayList<Material> selectMaterialList(String materialType, String keyword) {
        return materialDao.selectMaterialList(materialType, keyword);
    }

    public String materialDetail(Long materialId) {
        return materialDao.materialDetail(materialId);
    }

    @Transactional
    public boolean updateMaterial(Material m, MultipartFile imageFile) {
        // 자재 수정
        int result = materialDao.updateMaterial(m);
        // 파일 수정
        if (imageFile != null && !imageFile.isEmpty()) {
            StoredFile storedFile = fileStore.store(imageFile, "material_upfiles");
            materialDao.materialFileInsert(storedFile.toMaterialFile(m.getMaterialId()));
        }
        
        return result > 0;
    }

    public Material selectMaterial(Long finalMaterialId) {
        return materialDao.selectMaterial(finalMaterialId);
    }

    @Transactional
    public int deleteMaterial(Long materialId) {
    	return materialDao.deleteMaterial(materialId);
    }
}

package com.kh.burgerstack.material;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MaterialMapper {
    public int insert(Material m);

    public int materialFileInsert(MaterialFile materialFile);

    public ArrayList<Material> selectMaterialList();
    public Material materialDetail(Long materialId);
    public int updateMaterial(Material m);
    public Material selectMaterial(Long finalMaterialId);
    public int deleteMaterial(Long materialId);
}

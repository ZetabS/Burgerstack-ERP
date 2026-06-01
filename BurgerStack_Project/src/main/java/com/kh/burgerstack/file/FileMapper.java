package com.kh.burgerstack.file;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FileMapper {
    public int insert(StoredFile file);

    public StoredFile findById(long fildId);

    public void markDeleted(long fileId);
}

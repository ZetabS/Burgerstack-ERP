package com.kh.burgerstack.file;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface FileMapper {
    public int insert(StoredFile file);

    public StoredFile findActiveById(@Param("fileId") long fileId);

    public int markDeleted(@Param("fileId") long fileId);
}

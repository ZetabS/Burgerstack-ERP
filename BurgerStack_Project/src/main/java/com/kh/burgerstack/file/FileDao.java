package com.kh.burgerstack.file;

import java.util.Optional;

import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class FileDao {
    private final FileMapper fileMapper;

    public StoredFile save(StoredFile storedFile) {
        fileMapper.insert(storedFile);
        return fileMapper.findActiveById(storedFile.getFileId());
    }

    public Optional<StoredFile> findById(long fileId) {
        return Optional.ofNullable(fileMapper.findActiveById(fileId));
    }

    public void markDeleted(long fileId) {
        fileMapper.markDeleted(fileId);
    }
}

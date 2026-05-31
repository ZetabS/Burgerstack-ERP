package com.kh.burgerstack.file;

import java.util.Optional;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class FileStorage {
    private final FileDao fileDao;

    public StoredFile store(StoredFile storedFile) {
        return fileDao.save(storedFile);
    }

    public StoredFile store(MultipartFile multipartFile) {
        String originalName = extractOriginalName(multipartFile);
        String storedName = generateStoredName(originalName);

        StoredFile storedFile = createStoredFile(multipartFile, originalName, storedName);
        return fileDao.save(storedFile);
    }

    public Optional<StoredFile> findById(long fileId) {
        return fileDao.findById(fileId);
    }

    void delete(long fileId) {
        fileDao.markDeleted(fileId);
    }

    private StoredFile createStoredFile(
            MultipartFile multipartFile,
            String originalName,
            String storedName) {
        StoredFile storedFile = new StoredFile();
        storedFile.setOriginalName(originalName);
        storedFile.setStoredName(storedName);
        storedFile.setStoragePath(storedName); // TODO: 실제 저장 경로 정책 확정 후 변경
        storedFile.setMimeType(multipartFile.getContentType());
        storedFile.setFileSize(multipartFile.getSize());
        storedFile.setCreatedBy(1L); // TODO: 로그인 사용자 식별자 연동

        return storedFile;
    }

    private String generateStoredName(String originalName) {
        return originalName; // TODO: 실제 파일 저장 정책 확정 후 UUID 기반 저장명으로 변경
    }

    private String extractOriginalName(MultipartFile multipartFile) {
        String originalName = multipartFile.getOriginalFilename();

        if (originalName == null || originalName.isBlank()) {
            throw new IllegalArgumentException("파일명이 비어 있습니다.");
        }

        return originalName; // TODO: 실제 파일 저장 정책 확정 후 경로 제거 처리 추가
    }
}

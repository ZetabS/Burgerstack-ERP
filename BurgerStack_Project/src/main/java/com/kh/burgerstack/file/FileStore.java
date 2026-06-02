package com.kh.burgerstack.file;

import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDate;
import java.util.Optional;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.kh.burgerstack.config.FileStoreProperties;

@Component
public class FileStore {
    private final Path root;
    private final FileDao fileDao;

    public FileStore(FileStoreProperties properties, FileDao fileDao) {
        this.root = Path.of(properties.getRoot())
                .toAbsolutePath()
                .normalize();
        this.fileDao = fileDao;
    }

    public StoredFile store(MultipartFile multipartFile, long uploaderId) {
        if (multipartFile == null || multipartFile.isEmpty()) {
            throw new IllegalArgumentException("업로드 파일이 비어 있습니다.");
        }

        String originalName = extractOriginalName(multipartFile);
        String extension = extractExtension(originalName);
        String storedName = generateStoredName(extension);
        String storagePath = buildStoragePath(storedName);
        Path targetPath = resolveStoragePath(storagePath);

        try {
            Files.createDirectories(targetPath.getParent());
            multipartFile.transferTo(targetPath);

            StoredFile storedFile = StoredFile.builder()
                    .originalName(originalName)
                    .storedName(storedName)
                    .storagePath(storagePath)
                    .mimeType(multipartFile.getContentType())
                    .fileSize(multipartFile.getSize())
                    .createdBy(uploaderId)
                    .build();
            try {
                return fileDao.save(storedFile);
            } catch (Exception e) {
                Files.deleteIfExists(targetPath);
                throw e;
            }
        } catch (Exception e) {
            throw new FileStoreException("파일 저장에 실패했습니다.");
        }
    }

    public Optional<StoredFile> findById(long fileId) {
        return fileDao.findById(fileId);
    }

    public void delete(long fileId) {
        fileDao.markDeleted(fileId);
    }

    private String extractExtension(String originalName) {
        int index = originalName.lastIndexOf('.');

        if (index <= 0 || index == originalName.length() - 1) {
            return "";
        }

        return originalName.substring(index + 1)
                .toLowerCase();
    }

    private String buildStoragePath(String storedName) {
        LocalDate now = LocalDate.now();

        return "%04d/%02d/%02d/%s".formatted(now.getYear(), now.getMonthValue(), now.getDayOfMonth(), storedName);
    }

    private String generateStoredName(String extension) {
        String uuid = UUID.randomUUID()
                .toString();

        if (extension.isBlank()) {
            return uuid;
        }

        return uuid + "." + extension;
    }

    private String extractOriginalName(MultipartFile multipartFile) {
        String originalName = multipartFile.getOriginalFilename();

        if (originalName == null || originalName.isBlank()) {
            throw new IllegalArgumentException("파일명이 비어 있습니다.");
        }

        return Path.of(originalName.replace("\\", "/"))
                .getFileName()
                .toString();
    }

    private Path resolveStoragePath(String storagePath) {
        Path target = root.resolve(storagePath)
                .normalize();
        if (!target.startsWith(root)) {
            throw new FileStoreException("잘못된 파일 경로입니다.");
        }
        return target;
    }
}

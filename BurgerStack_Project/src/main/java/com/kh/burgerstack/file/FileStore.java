package com.kh.burgerstack.file;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.kh.burgerstack.config.FileStoreProperties;

@Component
public class FileStore {
	
    private final Path root;
    private final static String DEFAULT_PREFIX = "uploads";
    private static final int MAX_FILE_COUNT = 5;  // 첨부파일 최대 개수
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024L; // 단일 파일 최대 10MB

    private static final List<String> BLOCKED_EXTENSIONS = List.of(
    	    "exe", "bat", "cmd", "sh", "ps1", "vbs",	// 실행 파일
    	    "jsp", "php", "asp", "aspx",				// 서버 스크립트
    	    "jar", "war", "class",						// Java 실행 파일
    	    "msi", "dll", "so", "dylib"					// 라이브러리/설치파일
    	);
    
    public FileStore(FileStoreProperties properties) {
        this.root = Path.of(properties.getRoot())
                .toAbsolutePath()
                .normalize();
    }

    /**
     * 기본 파일 경로에 파일을 저장하고 결과를 반환합니다.<br>
     * <br>
     * 파일 경로 prefix를 붙이고 싶다면<br>
     * ```<br>
     * fileStore.store(file, "material_upfiles");<br>
     * ```<br>
     * 를 사용하세요.<br>
     *
     * @param multipartFile
     * @return StoredFile
     */
    public StoredFile store(MultipartFile multipartFile) {
        return store(multipartFile, null);
    }
    
    
//    /**
//     * 사용자가 지정한 경로에 파일을 저장하고 결과를 반환합니다.
//     * by. 송경민
//	   * 
//     * @param multipartFile
//     * @param prefix
//     * @return StoredFile
//     */
//    public StoredFile store(MultipartFile multipartFile, String prefix) {
//        if (multipartFile == null || multipartFile.isEmpty()) {
//            throw new IllegalArgumentException("업로드 파일이 비어 있습니다.");
//        }
//
//        String originalName = extractOriginalName(multipartFile);
//        String extension = extractExtension(originalName);
//        String storedName = generateStoredName(extension);
//        String storagePath = buildStoragePath(storedName, prefix);
//        Path targetPath = resolveStoragePath(storagePath);
//
//        try {
//            Files.createDirectories(targetPath.getParent());
//            multipartFile.transferTo(targetPath);
//
//            StoredFile storedFile = StoredFile.builder()
//                    .originalName(originalName)
//                    .storedName(storedName)
//                    .storagePath(storagePath)
//                    .mimeType(multipartFile.getContentType())
//                    .fileSize(multipartFile.getSize())
//                    .build();
//
//            return storedFile;
//        } catch (Exception e) {
//            throw new FileException("파일 저장에 실패했습니다.");
//        }
//    }

    /**
   * 사용자가 지정한 경로에 파일을 저장하고 결과를 반환합니다.
   * by. 김유화
   * 변경 사항 => 확장자, 크기 검증 추가
   *
   * @param multipartFile
   * @param prefix
   * @return StoredFile
   */
    public StoredFile store(MultipartFile multipartFile, String prefix) {
        if (multipartFile == null || multipartFile.isEmpty()) {
            throw new IllegalArgumentException("업로드 파일이 비어 있습니다.");
        }

        String originalName = extractOriginalName(multipartFile);
        String extension = extractExtension(originalName);

        // ✅ 금지 확장자 체크
        if (BLOCKED_EXTENSIONS.contains(extension.toLowerCase())) {
            throw new IllegalArgumentException("업로드할 수 없는 파일 형식입니다. (" + extension + ")");
        }

        // ✅ 단일 파일 크기 체크
        if (multipartFile.getSize() > MAX_FILE_SIZE) {
            throw new IllegalArgumentException(
                "파일 크기가 너무 큽니다. (최대 " + (MAX_FILE_SIZE / 1024 / 1024) + "MB)");
        }

        String storedName = generateStoredName(extension);
        String storagePath = buildStoragePath(storedName, prefix);
        Path targetPath = resolveStoragePath(storagePath);

        try {
            Files.createDirectories(targetPath.getParent());
            multipartFile.transferTo(targetPath);

            return StoredFile.builder()
                    .originalName(originalName)
                    .storedName(storedName)
                    .storagePath(storagePath)
                    .mimeType(multipartFile.getContentType())
                    .fileSize(multipartFile.getSize())
                    .build();
        } catch (IllegalArgumentException e) {
            throw e; // 검증 예외는 그대로 전파
        } catch (Exception e) {
            throw new FileException("파일 저장에 실패했습니다.");
        }
    }
    
    // ✅ 다중 파일 개수 검증 메서드 추가 (컨트롤러에서 호출)
    public void validateFileCount(MultipartFile[] files) {
        if (files == null) return;
        long nonEmptyCount = Arrays.stream(files)
                                   .filter(f -> f != null && !f.isEmpty())
                                   .count();
        if (nonEmptyCount > MAX_FILE_COUNT) {
            throw new IllegalArgumentException(
                "첨부파일은 최대 " + MAX_FILE_COUNT + "개까지 업로드 가능합니다.");
        }
    }
    
    /**
     * 저장된 파일을 삭제합니다.
     *
     * @param storedFile
     */
    public void delete(StoredFile storedFile) {
        try {
            Files.deleteIfExists(resolveStoragePath(storedFile.getStoragePath()));
        } catch (IOException e) {
            throw new FileException("파일 삭제에 실패했습니다.");
        }
    }

    private String extractExtension(String originalName) {
        int index = originalName.lastIndexOf('.');

        if (index <= 0 || index == originalName.length() - 1) {
            return "";
        }

        return originalName.substring(index + 1)
                .toLowerCase();
    }

    private String buildStoragePath(String storedName, String prefix) {
        LocalDate now = LocalDate.now();

        if (prefix == null || prefix.isBlank()) {
            return "%s/%04d/%02d/%02d/%s".formatted(
                    DEFAULT_PREFIX,
                    now.getYear(),
                    now.getMonthValue(),
                    now.getDayOfMonth(),
                    storedName);
        }

        return "%s/%04d/%02d/%02d/%s".formatted(
                prefix,
                now.getYear(),
                now.getMonthValue(),
                now.getDayOfMonth(),
                storedName);

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
            throw new FileException("잘못된 파일 경로입니다.");
        }
        return target;
    }
    
    
    /**
     * 파일 다운로드용 메소드 추가
     * @param storagePath
     * @return
     */
    public Path resolve(String storagePath) {
        return resolveStoragePath(storagePath); // 이미 있는 private 메서드를 public으로 노출
    }
}

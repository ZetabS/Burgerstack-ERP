package com.kh.burgerstack.file;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@ToString
public class FileResource {
    private String originalName;
    private String mimeType;
    private long fileSize;
    private Resource resource;

    public static FileResource fromStoredFile(StoredFile storedFile) {
        return new FileResource(
                storedFile.getOriginalName(),
                storedFile.getMimeType(),
                storedFile.getFileSize(),
                new FileSystemResource(storedFile.getStoragePath()));
    }
}

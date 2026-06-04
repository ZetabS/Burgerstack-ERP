package com.kh.burgerstack.file;

import java.nio.charset.StandardCharsets;

import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/files")
public class FileController {
    private final FileService fileService;

    @GetMapping("/{fileId}")
    public ResponseEntity<Resource> viewFile(Long fileId) {
        FileResource fileResource = fileService.loadFile(fileId);
        return ResponseEntity.ok()
                .contentType(resolveMediaType(fileResource.getMimeType()))
                .contentLength(fileResource.getFileSize())
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        ContentDisposition.inline()
                                .filename(fileResource.getOriginalName(), StandardCharsets.UTF_8)
                                .build()
                                .toString())
                .body(fileResource.getResource());
    }

    @GetMapping("/{fileId}/download")
    public ResponseEntity<Resource> downloadFile(Long fileId) {
        FileResource fileResource = fileService.loadFile(fileId);
        return ResponseEntity.ok()
                .contentType(resolveMediaType(fileResource.getMimeType()))
                .contentLength(fileResource.getFileSize())
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        ContentDisposition.attachment()
                                .filename(fileResource.getOriginalName(), StandardCharsets.UTF_8)
                                .build()
                                .toString())
                .body(fileResource.getResource());
    }

    private MediaType resolveMediaType(String mimeType) {
        if (mimeType == null || mimeType.isBlank()) {
            return MediaType.APPLICATION_OCTET_STREAM;
        }
        return MediaType.parseMediaType(mimeType);
    }
}

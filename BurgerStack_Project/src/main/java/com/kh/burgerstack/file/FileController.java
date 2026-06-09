package com.kh.burgerstack.file;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import org.springframework.core.io.PathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.burgerstack.config.FileStoreProperties;

@RestController
@RequestMapping("/material-files")
public class FileController {

    private final Path root;

    public FileController(FileStoreProperties properties) {
        this.root = Path.of(properties.getRoot())
                .toAbsolutePath()
                .normalize();
    }

    @GetMapping("/{storedName}")
    public ResponseEntity<Resource> serveFile(@PathVariable String storedName) throws IOException {

        Path filePath = Files.walk(root)
                .filter(p -> p.getFileName().toString().equals(storedName))
                .findFirst()
                .orElseThrow(() -> new FileException("파일을 찾을 수 없습니다."));

        Resource resource = new PathResource(filePath);
        String contentType = Files.probeContentType(filePath);
        if (contentType == null) contentType = "application/octet-stream";

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_TYPE, contentType)
                .body(resource);
    }
}
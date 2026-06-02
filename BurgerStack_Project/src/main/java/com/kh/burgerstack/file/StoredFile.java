package com.kh.burgerstack.file;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class StoredFile {
    private Long fileId;
    private String originalName;
    private String storedName;
    private String storagePath;
    private String mimeType;
    private Long fileSize;
    private LocalDateTime deletedAt;
    private Long createdBy;
    private LocalDateTime createdAt;
}

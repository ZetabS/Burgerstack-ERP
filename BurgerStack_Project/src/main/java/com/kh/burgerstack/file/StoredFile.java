package com.kh.burgerstack.file;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class StoredFile {
    private long fileId;
    private String originalName;
    private String storedName;
    private String storagePath;
    private String mimeType;
    private long fileSize;
    private LocalDateTime deletedAt;
    private long createdBy;
    private LocalDateTime createdAt;
}

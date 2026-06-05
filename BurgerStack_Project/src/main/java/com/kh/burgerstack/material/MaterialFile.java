package com.kh.burgerstack.material;

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
public class MaterialFile {
    private Long materialFileId;
    private String originalName;
    private String storedName;
    private String storagePath;
    private LocalDateTime createdAt;
    private LocalDateTime deletedAt;
    private Long materialId;
}

package com.kh.burgerstack.notice;

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
public class NoticeFile {
    private Long noticeFileId;
    private String originalName;
    private String storedName;
    private String storagePath;
    private LocalDateTime createdAt;
    private LocalDateTime deletedAt;
    private Long noticeId;
}

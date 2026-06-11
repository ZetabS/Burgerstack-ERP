package com.kh.burgerstack.notice;

import java.time.LocalDateTime;
import java.util.ArrayList;

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
public class Notice {
    private Long noticeId;
    private String title;
    private String content;
    private LocalDateTime createdAt;
    private LocalDateTime deletedAt;
    
    private String listDate;   // 2026-06-09 (24)시:분
    private String detailDate; // 2026-06-09 (24)시:분:초
    
    private ArrayList<NoticeFile> fileList; // 상세조회 시 함께 담아갈 파일 리스트
}

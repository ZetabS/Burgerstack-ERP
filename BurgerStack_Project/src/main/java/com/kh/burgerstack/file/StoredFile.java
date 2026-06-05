package com.kh.burgerstack.file;

import java.time.LocalDateTime;

import com.kh.burgerstack.inquiry.InquiryFile;
import com.kh.burgerstack.material.MaterialFile;
import com.kh.burgerstack.notice.NoticeFile;

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
    private String originalName;
    private String storedName;
    private String storagePath;
    private String mimeType;
    private Long fileSize;
    private LocalDateTime deletedAt;
    private LocalDateTime createdAt;

    public MaterialFile toMaterialFile(long materialId) {
        return new MaterialFile(
                null,
                originalName,
                storedName,
                storagePath,
                createdAt,
                deletedAt,
                materialId);
    }

    public NoticeFile toNoticeFile(long noticeId) {
        return new NoticeFile(
                null,
                originalName,
                storedName,
                storagePath,
                createdAt,
                deletedAt,
                noticeId);
    }

    public InquiryFile toInquiryFile(long inquiryId, String attachTarget) {
        return new InquiryFile(
                null,
                originalName,
                storedName,
                storagePath,
                attachTarget,
                createdAt,
                deletedAt,
                inquiryId);
    }
}

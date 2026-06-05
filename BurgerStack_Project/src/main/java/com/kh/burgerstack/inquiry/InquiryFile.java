package com.kh.burgerstack.inquiry;

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
public class InquiryFile {
    private Long inquiryFileId;
    private String originalName;
    private String storedName;
    private String storagePath;
    private String attachTarget;
    private LocalDateTime createdAt;
    private LocalDateTime deletedAt;
    private Long inquiryId;
}

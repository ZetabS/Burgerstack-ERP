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
    private Long inquiryId;
    private Long fileId;
    private String attachTarget;
    private LocalDateTime deletedAt;
    private LocalDateTime createdAt;
}

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
public class Inquiry {

    private Long inquiryId;
    private Long storeId;
    private String title;
    private String content;
    private String status;
    private String answerContent;
    private Long answeredBy;
    private LocalDateTime answeredAt;
    private LocalDateTime deletedAt;
    private Long createdBy;
    private LocalDateTime createdAt;
    private Long updatedBy;
    private LocalDateTime updatedAt;
}

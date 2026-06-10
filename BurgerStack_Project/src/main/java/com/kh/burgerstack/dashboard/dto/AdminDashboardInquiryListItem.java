package com.kh.burgerstack.dashboard.dto;

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
public class AdminDashboardInquiryListItem {
    private Long inquiryId;
    private String inquiryCode;
    private String title;
    private String status;
    private LocalDateTime createdAt;
    private String storeName;
    private Long storeId;
}

package com.kh.burgerstack.inquiry;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kh.burgerstack.dashboard.dto.AdminDashboardInquiryListItem;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InquiryDaoHO {
    private final InquiryMapper inquiryMapper;

    public List<AdminDashboardInquiryListItem> findRecent(int count) {
        return inquiryMapper.findTopN(count);
    }
}

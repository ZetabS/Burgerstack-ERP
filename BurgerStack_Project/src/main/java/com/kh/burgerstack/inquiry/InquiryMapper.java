package com.kh.burgerstack.inquiry;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.burgerstack.dashboard.dto.AdminDashboardInquiryListItem;

@Mapper
public interface InquiryMapper {
    public List<AdminDashboardInquiryListItem> findTopN(
            @Param("count") int count);
}
package com.kh.burgerstack.inquiry;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InquiryDaoHO {
	
	private final InquiryMapper inquiryMapper;
	
	public List<Inquiry> InquiryList(String condition, String keyword, RowBounds rowBounds) {
        return inquiryMapper.InquiryList(condition, keyword, rowBounds);
    }

    public int getTotalCount(String condition, String keyword) {
        return inquiryMapper.getTotalCount(condition, keyword);
    }

}

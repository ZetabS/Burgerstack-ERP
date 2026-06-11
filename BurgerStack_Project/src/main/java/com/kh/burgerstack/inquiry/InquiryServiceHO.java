package com.kh.burgerstack.inquiry;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InquiryServiceHO {

	private final InquiryDaoHO inquiryDaoHO;

	public List<Inquiry> InquiryList(String condition, String keyword, int page, int limit) {
        int offset = (page - 1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);
        return inquiryDaoHO.InquiryList(condition, keyword, rowBounds);
    }

    public int getTotalCount(String condition, String keyword) {
        return inquiryDaoHO.getTotalCount(condition, keyword);
    }

	public Inquiry InquiryListDetail(long inquiryId) {
		return inquiryDaoHO.InquiryListDetail(inquiryId);
	}

	public int InquiryEdit(Inquiry i) {
		return inquiryDaoHO.InquiryEdit(i);
	}

	public int InquiryDelete(long inquiryId) {
		return inquiryDaoHO.inquiryDelete(inquiryId);
	}
	
}

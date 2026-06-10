package com.kh.burgerstack.inquiry;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InquiryDaoBO {

	private final InquiryMapper inquiryMapper;

	public int InquiryEnroll(Inquiry inquiry) {
		return inquiryMapper.inquiryEnroll(inquiry);
	}

	public List<Inquiry> InquiryList(Long storeId, String condition, String keyword, RowBounds rowBounds) {
        return inquiryMapper.InquiryList(storeId, condition, keyword, rowBounds);
    }

    public int getTotalCount(Long storeId, String condition, String keyword) {
        return inquiryMapper.getTotalCount(storeId, condition, keyword);
    }

	public Inquiry InquiryListDetail(String inquiryId) {
		return inquiryMapper.InquiryListDetail(inquiryId);
	}

	public int InquiryEdit(Inquiry i) {
		return inquiryMapper.InquiryEdit(i);
	}

}

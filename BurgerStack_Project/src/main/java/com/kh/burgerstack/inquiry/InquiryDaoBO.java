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

	public int insertInquiryFile(InquiryFile file) {
	    return inquiryMapper.insertInquiryFile(file);
	}

	public List<Inquiry> InquiryList(Long storeId, String condition, String keyword, String answerStatus, RowBounds rowBounds) {
        return inquiryMapper.InquiryList(storeId, condition, keyword, answerStatus, rowBounds);
    }

    public int getTotalCount(Long storeId, String condition, String keyword, String answerStatus) {
        return inquiryMapper.getTotalCount(storeId, condition, keyword, answerStatus);
    }

	public Inquiry InquiryListDetail(long inquiryId) {
		return inquiryMapper.InquiryListDetail(inquiryId);
	}

	public int InquiryEdit(Inquiry i) {
		return inquiryMapper.InquiryEdit(i);
	}

	public int InquiryDelete(long inquiryId) {
		return inquiryMapper.InquiryDelete(inquiryId);
	}

}
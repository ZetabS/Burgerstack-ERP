package com.kh.burgerstack.inquiry;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InquiryServiceBO {

	private final InquiryDaoBO inquiryDaoBO;

	public int InquiryEnroll(Inquiry inquiry) {
		return inquiryDaoBO.InquiryEnroll(inquiry);
	}

	public List<Inquiry> InquiryList(Long storeId, String condition, String keyword, int page, int limit) {
        int offset = (page - 1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);
        return inquiryDaoBO.InquiryList(storeId, condition, keyword, rowBounds);
    }

    public int getTotalCount(Long storeId, String condition, String keyword) {
        return inquiryDaoBO.getTotalCount(storeId, condition, keyword);
    }
	
}

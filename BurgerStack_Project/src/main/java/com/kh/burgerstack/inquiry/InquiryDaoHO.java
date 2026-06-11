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
        return inquiryMapper.InquiryListHO(condition, keyword, rowBounds);
    }

    public int getTotalCount(String condition, String keyword) {
        return inquiryMapper.getTotalCountHO(condition, keyword);
    }

	public Inquiry InquiryListDetail(long inquiryId) {
		return inquiryMapper.InquiryListDetail(inquiryId);
	}

	public int InquiryEdit(Inquiry i) {
		return inquiryMapper.InquiryEditHO(i);
	}

	public int inquiryDelete(long inquiryId) {
		return inquiryMapper.InquiryDeleteHO(inquiryId);
	}

}

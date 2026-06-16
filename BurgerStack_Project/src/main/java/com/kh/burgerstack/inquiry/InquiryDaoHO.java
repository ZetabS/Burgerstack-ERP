package com.kh.burgerstack.inquiry;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.dashboard.dto.AdminDashboardInquiryListItem;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InquiryDaoHO {
	
	private final InquiryMapper inquiryMapper;
	
	public List<Inquiry> InquiryList(String condition, String keyword, String answerStatus, RowBounds rowBounds) {
        return inquiryMapper.InquiryListHO(condition, keyword, answerStatus, rowBounds);
    }

    public int getTotalCount(String condition, String keyword, String answerStatus) {
        return inquiryMapper.getTotalCountHO(condition, keyword, answerStatus);
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

    public List<AdminDashboardInquiryListItem> findRecent(int count) {
        return inquiryMapper.findTopN(count);
    }

    public int countUnanswerd() {
        return inquiryMapper.countUnanswered();
    }
}

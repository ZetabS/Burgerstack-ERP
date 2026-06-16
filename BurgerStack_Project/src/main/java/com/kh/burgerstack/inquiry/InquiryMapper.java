package com.kh.burgerstack.inquiry;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.kh.burgerstack.dashboard.dto.AdminDashboardInquiryListItem;
import org.apache.ibatis.session.RowBounds;

@Mapper
public interface InquiryMapper {

	int inquiryEnroll(Inquiry inquiry);
	
	int insertInquiryFile(InquiryFile file);

	// 점주 문의사항 목록조회
	List<Inquiry> InquiryList(@Param("storeId") Long storeId, @Param("condition") String condition,
			@Param("keyword") String keyword, RowBounds rowBounds);

	int getTotalCount(@Param("storeId") Long storeId, @Param("condition") String condition,
			@Param("keyword") String keyword);
	
	
	// 본사 문의사항 목록조회
	List<Inquiry> InquiryListHO(@Param("condition") String condition,
			@Param("keyword") String keyword, RowBounds rowBounds);

	int getTotalCountHO(@Param("condition") String condition,
			@Param("keyword") String keyword);
	
	
	

	Inquiry InquiryListDetail(long inquiryId);

	int InquiryEdit(Inquiry i);

	int InquiryDelete(long inquiryId);

	int InquiryEditHO(Inquiry i);

	int InquiryDeleteHO(long inquiryId);
   public List<AdminDashboardInquiryListItem> findTopN(
            @Param("count") int count);

    public int countUnanswered();
}

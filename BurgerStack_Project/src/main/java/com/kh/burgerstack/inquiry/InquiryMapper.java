package com.kh.burgerstack.inquiry;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

@Mapper
public interface InquiryMapper {

	int inquiryEnroll(Inquiry inquiry);

	List<Inquiry> InquiryList(@Param("storeId") Long storeId, @Param("condition") String condition,
			@Param("keyword") String keyword, RowBounds rowBounds);

	int getTotalCount(@Param("storeId") Long storeId, @Param("condition") String condition,
			@Param("keyword") String keyword);

	Inquiry InquiryListDetail(String inquiryId);

	int InquiryEdit(Inquiry i);

	int InquiryDelete(String inquiryId);
}

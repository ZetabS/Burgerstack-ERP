package com.kh.burgerstack.notice;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.kh.burgerstack.common.pagination.PagingRequest;

@Mapper
public interface NoticeMapper {

	public ArrayList<Notice> selectNoticeList(PagingRequest pagingRequest);
	public int selectNoticeCount();

}


package com.kh.burgerstack.notice;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;

@Repository
public class NoticeDao {

	@Autowired
	private NoticeMapper noticeMapper;
	
	public int selectNoticeCount() {
		return noticeMapper.selectNoticeCount();
	} //selectNoticeCount
	
	public ArrayList<Notice> selectNoticeList(PagingRequest pagingRequest) {
	    return noticeMapper.selectNoticeList(pagingRequest);
	}
	
	
}

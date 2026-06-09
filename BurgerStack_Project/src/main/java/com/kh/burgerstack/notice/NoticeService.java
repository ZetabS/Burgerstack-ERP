package com.kh.burgerstack.notice;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.burgerstack.common.pagination.PagingRequest;

@Service
public class NoticeService {

	@Autowired
	private NoticeDao noticeDao;
	
	public int selectNoticeCount() {
		return noticeDao.selectNoticeCount();
	}//selectNoticeCount
	
	public ArrayList<Notice> selectNoticeList(PagingRequest pagingRequest) {
		return noticeDao.selectNoticeList(pagingRequest);
	} //selectNoticeList
}

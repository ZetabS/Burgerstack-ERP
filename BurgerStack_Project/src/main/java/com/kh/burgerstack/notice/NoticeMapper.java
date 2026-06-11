package com.kh.burgerstack.notice;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.kh.burgerstack.common.pagination.PagingRequest;

@Mapper
public interface NoticeMapper {

    ArrayList<Notice> selectNoticeList(PagingRequest pagingRequest);
    int selectNoticeCount();
    int insertNotice(Notice n);
    int insertNoticeFile(NoticeFile noticeFile);
    Notice noticeDetail(Long noticeId);
    ArrayList<NoticeFile> noticeDetailFileList(Long noticeId);
    int updateNotice(Notice n);
	int deleteNotice(Long noticeId);
	NoticeFile selectNoticeFile(Long noticeFileId);
    
}

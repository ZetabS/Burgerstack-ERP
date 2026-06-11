package com.kh.burgerstack.notice;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.burgerstack.common.pagination.PagingRequest;

@Repository
public class NoticeDao {

    @Autowired
    private NoticeMapper noticeMapper;

    public int selectNoticeCount() {
        return noticeMapper.selectNoticeCount();
    }

    public ArrayList<Notice> selectNoticeList(PagingRequest pagingRequest) {
        return noticeMapper.selectNoticeList(pagingRequest);
    }

    public int insertNotice(Notice n) {
        return noticeMapper.insertNotice(n);
    }

    public int insertNoticeFile(NoticeFile noticeFile) {
        return noticeMapper.insertNoticeFile(noticeFile);
    }

    public Notice noticeDetail(Long noticeId) {
        return noticeMapper.noticeDetail(noticeId);
    }

    public ArrayList<NoticeFile> noticeDetailFileList(Long noticeId) {
        return noticeMapper.noticeDetailFileList(noticeId);
    }
    
    public int updateNotice(Notice n) {
        return noticeMapper.updateNotice(n);
    }

	public int deleteNotice(Long noticeId) {
		return noticeMapper.deleteNotice(noticeId);
	}

	public NoticeFile selectNoticeFile(Long noticeFileId) {
		return noticeMapper.selectNoticeFile(noticeFileId);
	}

}

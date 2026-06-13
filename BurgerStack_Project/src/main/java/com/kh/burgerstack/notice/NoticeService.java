package com.kh.burgerstack.notice;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.file.FileStore;

@Service
public class NoticeService {

    @Autowired
    private NoticeDao noticeDao;
    
    @Autowired
    private FileStore fileStore;

    public int selectNoticeCount() {
        return noticeDao.selectNoticeCount();
    }

    public ArrayList<Notice> selectNoticeList(PagingRequest pagingRequest) {
        return noticeDao.selectNoticeList(pagingRequest);
    }

    /**
     * 글 등록 + 첨부파일 등록 (일반 파일 + Quill 이미지 통합)
     */
    @Transactional(rollbackFor = Exception.class)
    public int insertNotice(Notice n, ArrayList<NoticeFile> fileList) {
        try {
            // 1. 글 INSERT (selectKey로 noticeId 확보)
            int result = noticeDao.insertNotice(n);
            if (result <= 0) {
                throw new RuntimeException("공지사항 글 등록 실패");
            }

            // 2. 전체 파일(일반 + Quill 이미지) INSERT
            if (fileList != null && !fileList.isEmpty()) {
                for (NoticeFile file : fileList) {
                    file.setNoticeId(n.getNoticeId());
                    noticeDao.insertNoticeFile(file);
                }
            }

            return 1;

        } catch (Exception e) {
            // 물리 파일 롤백 삭제
            if (fileList != null && !fileList.isEmpty()) {
                for (NoticeFile file : fileList) {
                    String fullPath = file.getStoragePath() + "/" + file.getStoredName();
                    java.io.File targetFile = new java.io.File(fullPath);
                    if (targetFile.exists()) {
                        targetFile.delete();
                    }
                }
            }
            throw e;
        }
    }

    public Notice noticeDetail(Long noticeId) {
        Notice n = noticeDao.noticeDetail(noticeId);
        if (n != null) {
            n.setFileList(noticeDao.noticeDetailFileList(noticeId));
        }
        return n;
    }
	
	/**
	 *  > selectFileList: 기존 첨부파일 목록 조회
	 *    noticeDetail()에서 이미 notice.fileList를 채워주므로,
	 *    컨트롤러에서 별도 호출 없이 noticeDetail() 하나로 충분.
	 *    하지만 단독으로 필요한 경우를 위해 구현.
	 */
	public ArrayList<NoticeFile> selectFileList(Long noticeId) {
	    return noticeDao.noticeDetailFileList(noticeId);
	}

	/**
	 * updateNotice: 글 수정 + 새 파일 추가 (Quill 이미지 포함)
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateNotice(Notice n, ArrayList<NoticeFile> newFileList, ArrayList<Long> deleteFileIds) {
	    int result = noticeDao.updateNotice(n);

	    // 새 파일 INSERT
	    if (newFileList != null && !newFileList.isEmpty()) {
	        for (NoticeFile nf : newFileList) {
	            nf.setNoticeId(n.getNoticeId());
	            noticeDao.insertNoticeFile(nf);
	        }
	    }

	    // X버튼으로 삭제 요청된 파일: DB soft delete + 물리 파일 삭제
	    if (deleteFileIds != null && !deleteFileIds.isEmpty()) {
	        for (Long fileId : deleteFileIds) {
	            noticeDao.deleteNoticeFile(fileId);
	        }
	    }

	    return result;
	}

	public int deleteNotice(Long noticeId) {
		return noticeDao.deleteNotice(noticeId);
	}

	public NoticeFile selectNoticeFile(Long noticeFileId) {
		return noticeDao.selectNoticeFile(noticeFileId);
	}
	
	
	
}

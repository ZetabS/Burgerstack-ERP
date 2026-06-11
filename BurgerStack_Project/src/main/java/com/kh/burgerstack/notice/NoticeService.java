package com.kh.burgerstack.notice;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.burgerstack.common.pagination.PagingRequest;

@Service
public class NoticeService {

    @Autowired
    private NoticeDao noticeDao;

    public int selectNoticeCount() {
        return noticeDao.selectNoticeCount();
    }

    public ArrayList<Notice> selectNoticeList(PagingRequest pagingRequest) {
        return noticeDao.selectNoticeList(pagingRequest);
    }

    /**
     * 글 등록 + 첨부파일 등록 (일반 파일 + Quill 이미지 통합)
     * ✅ 컨트롤러에서 fileList에 Quill 이미지도 합쳐서 넘기므로 메서드 시그니처 변경 없음
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
                    file.setNoticeId(n.getNoticeId()); // ✅ 실제 글번호 주입
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
	 * ✅ selectFileList: 기존 첨부파일 목록 조회 (미구현 상태였던 것 완성)
	 *    noticeDetail()에서 이미 notice.fileList를 채워주므로,
	 *    컨트롤러에서 별도 호출 없이 noticeDetail() 하나로 충분합니다.
	 *    하지만 단독으로 필요한 경우를 위해 구현합니다.
	 */
	public ArrayList<NoticeFile> selectFileList(Long noticeId) {
	    return noticeDao.noticeDetailFileList(noticeId); // ✅ Dao 위임
	}

	/**
	 * ✅ updateNotice: 글 수정 + 새 파일 추가 (Quill 이미지 포함)
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateNotice(Notice n, ArrayList<NoticeFile> fileList) {
	    // 1. 글 본문(제목, 내용) 업데이트
	    int result = noticeDao.updateNotice(n);

	    // 2. 새로 추가된 파일 INSERT (일반 파일 + Quill 이미지 통합)
	    if (result > 0 && fileList != null && !fileList.isEmpty()) {
	        for (NoticeFile nf : fileList) {
	            nf.setNoticeId(n.getNoticeId()); // ✅ noticeId 확실히 주입
	            noticeDao.insertNoticeFile(nf);
	        }
	    }

	    return result;
	}

	public int deleteNotice(Long noticeId) {
		return noticeDao.deleteNotice(noticeId);
	}
	
	
	
}

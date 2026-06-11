package com.kh.burgerstack.notice;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.common.template.NoticeXssUtil;
import com.kh.burgerstack.common.template.XssDefencePolicy;
import com.kh.burgerstack.file.FileStore;
import com.kh.burgerstack.file.StoredFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/notices")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private FileStore fileStore;

    
    /**
     * 공지사항 전체 목록 조회
     */
    @GetMapping("")
    public String selectNoticeList(PagingRequest pagingRequest, Model model) {
        int totalCount = noticeService.selectNoticeCount();
        model.addAttribute("pageInfo", pagingRequest.toPageInfo(totalCount));

        ArrayList<Notice> list = noticeService.selectNoticeList(pagingRequest);

        DateTimeFormatter formatterList   = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        DateTimeFormatter formatterDetail = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        for (Notice n : list) {
            if (n.getCreatedAt() != null) {
                n.setListDate(n.getCreatedAt().format(formatterList));
                n.setDetailDate(n.getCreatedAt().format(formatterDetail));
            }
        }

        model.addAttribute("notices", list);
        return "notice/noticeListViewHO";
    }


    /**
     * 공지사항 글작성 페이지 진입
     */
    @GetMapping({"/new", "new"})
    public String noticeEnrollForm(HttpSession session) {
        // 글쓰기 페이지 진입 시 세션의 Quill 이미지 목록 초기화
        session.removeAttribute("quillImageFiles");
        return "notice/noticeEnrollForm";
    }


    
    /**
     * 공지사항 등록
     */
    @PostMapping("")
    public String insertNotice(Notice n,
                               MultipartFile[] files,
                               HttpSession session) {

        // 0. XSS 방어
        n.setTitle(XssDefencePolicy.defence(n.getTitle()));
        n.setContent(NoticeXssUtil.cleanContent(n.getContent()));

        // 1. 일반 첨부파일(input file) 서버 저장
        ArrayList<NoticeFile> fileList = new ArrayList<>();
        if (files != null && files.length > 0) {
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    StoredFile storedFile = fileStore.store(file, "notice_upfiles");
                    NoticeFile noticeFile = storedFile.toNoticeFile(0);
                    fileList.add(noticeFile);
                }
            }
        }

        // 2. 세션에 임시 보관된 Quill 이미지 파일 목록도 fileList에 합치기
        ArrayList<NoticeFile> quillImageFiles =
            (ArrayList<NoticeFile>) session.getAttribute("quillImageFiles");
        if (quillImageFiles != null && !quillImageFiles.isEmpty()) {
            fileList.addAll(quillImageFiles);
            session.removeAttribute("quillImageFiles"); // 세션 정리
        }

        // 3. 서비스 호출
        int result = noticeService.insertNotice(n, fileList);

        if (result > 0) {
            session.setAttribute("alertMsg", "공지사항 등록이 완료되었습니다.");
            return "redirect:/admin/notices";
        } else {
            session.setAttribute("alertMsg", "공지사항 등록에 실패했습니다.");
            return "redirect:/admin/notices/new";
        }
    }


    /**
     * Quill 에디터 본문 이미지 비동기 업로드
     *  DB INSERT 없이 서버 파일 저장만 하고, NoticeFile 정보를 세션에 임시 보관
     *  > insertNotice 시 세션에서 꺼내 fileList에 합쳐서 한 번에 DB 등록
     */
 // ===== NoticeController.java uploadQuillImage 메서드 전체 교체 =====

    @PostMapping("/uploadImage")
    @ResponseBody
    public Map<String, Object> uploadQuillImage(@RequestParam("image") MultipartFile file,
                                                 HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

        if (file.isEmpty()) {
            response.put("uploaded", false);
            return response;
        }

        try {
            // ✅ fileStore로 통일 — 상대경로로 저장되어 download 메서드와 호환됨
            StoredFile storedFile = fileStore.store(file, "upload");

            // 에디터 src URL: 상대경로를 웹 URL로 변환
            // storagePath = "upload/2026/06/11/uuid.png"
            String fileUrl = request.getContextPath() + "/resources/" + storedFile.getStoragePath();

            // 세션에 NoticeFile 보관 (storagePath가 상대경로로 통일됨)
            NoticeFile noticeFile = new NoticeFile();
            noticeFile.setOriginalName(storedFile.getOriginalName());
            noticeFile.setStoredName(storedFile.getStoredName());
            noticeFile.setStoragePath(storedFile.getStoragePath()); // ✅ 상대경로
            noticeFile.setNoticeId(0L);

            HttpSession session = request.getSession();
            ArrayList<NoticeFile> quillImageFiles =
                (ArrayList<NoticeFile>) session.getAttribute("quillImageFiles");
            if (quillImageFiles == null) {
                quillImageFiles = new ArrayList<>();
            }
            quillImageFiles.add(noticeFile);
            session.setAttribute("quillImageFiles", quillImageFiles);

            response.put("uploaded", true);
            response.put("url", fileUrl);

        } catch (Exception e) {
            e.printStackTrace();
            response.put("uploaded", false);
        }

        return response;
    }


    /**
     * 공지사항 상세 조회
     */
    @GetMapping("/{noticeId:[0-9]+}")
    public String noticeDetail(@PathVariable("noticeId") Long noticeId, Model model) {
        Notice n = noticeService.noticeDetail(noticeId);
        model.addAttribute("notice", n);
        return "notice/noticeDetailHO";
    }

    
	/**
	 * 파일 다운로드
	 */
    @GetMapping("/download")
    public ResponseEntity<InputStreamResource> download(
            @RequestParam("noticeFileId") Long noticeFileId) {
        try {
            NoticeFile noticeFile = noticeService.selectNoticeFile(noticeFileId);
            if (noticeFile == null) return ResponseEntity.notFound().build();

            // 경로 resolve
            File file = fileStore.resolve(noticeFile.getStoragePath()).toFile();

            System.out.println("[download] 최종 경로: " + file.getAbsolutePath());
            System.out.println("[download] 존재 여부: " + file.exists());

            if (!file.exists()) return ResponseEntity.notFound().build();

            String encodedFileName = URLEncoder.encode(noticeFile.getOriginalName(), StandardCharsets.UTF_8)
                                               .replace("+", "%20");

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + encodedFileName + "\"")
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .contentLength(file.length())
                    .body(new InputStreamResource(new FileInputStream(file)));

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * 공지사항 수정 페이지 이동
     */
    @GetMapping("{noticeId}/edit")
    public String noticeEdit(@PathVariable("noticeId") Long noticeId,
                              HttpSession session,
                              Model model) {
        // 수정 페이지 진입 시도 세션의 Quill 이미지 목록 초기화
        session.removeAttribute("quillImageFiles");

        Notice notice = noticeService.noticeDetail(noticeId); // fileList도 함께 조회됨
        model.addAttribute("notice", notice);
        // notice.fileList 로 JSP에서 접근하므로 별도 addAttribute 불필요
        return "notice/noticeEnrollForm";
    }

    /**
     * 공지사항 수정 처리
     */
    @PostMapping({"/{noticeId}", "{noticeId}"})
    public String updateNotice(@PathVariable("noticeId") Long noticeId,
                                Notice n,
                                MultipartFile[] files,
                                HttpSession session) {

        n.setNoticeId(noticeId);
        n.setTitle(XssDefencePolicy.defence(n.getTitle()));
        n.setContent(NoticeXssUtil.cleanContent(n.getContent()));

        // 일반 첨부파일 처리
        ArrayList<NoticeFile> fileList = new ArrayList<>();
        if (files != null && files.length > 0) {
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    StoredFile storedFile = fileStore.store(file, "notice_upfiles");
                    NoticeFile noticeFile = storedFile.toNoticeFile(noticeId);
                    fileList.add(noticeFile);
                }
            }
        }

        // 세션에 보관된 Quill 이미지도 fileList에 합치기
        ArrayList<NoticeFile> quillImageFiles =
            (ArrayList<NoticeFile>) session.getAttribute("quillImageFiles");
        if (quillImageFiles != null && !quillImageFiles.isEmpty()) {
            fileList.addAll(quillImageFiles);
            session.removeAttribute("quillImageFiles");
        }

        int result = noticeService.updateNotice(n, fileList);

        if (result > 0) {
            session.setAttribute("alertMsg", "공지사항이 수정되었습니다.");
        } else {
            session.setAttribute("alertMsg", "수정에 실패했습니다.");
        }

        return "redirect:/admin/notices/" + noticeId;
    }


    /**
     * 공지사항 삭제
     */
    @PostMapping({"/{noticeId}/delete", "{noticeId}/delete"})
    public String deleteNotice(@PathVariable("noticeId") Long noticeId, HttpSession session) {
    	
    	int result = noticeService.deleteNotice(noticeId);
    	
    	if (result > 0) {
            session.setAttribute("alertMsg", "공지사항이 삭제되었습니다.");
        } else {
            session.setAttribute("alertMsg", "삭제에 실패했습니다.");
        }
    	return "redirect:/admin/notices";
    }

}
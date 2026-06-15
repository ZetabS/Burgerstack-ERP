package com.kh.burgerstack.notice;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.file.FileStore;

@Controller
@RequestMapping("/owner/notices")
public class OwnerNoticeController {
	
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
        
        for (Notice n : list) {
            if (n.getCreatedAt() != null) {
                n.setListDate(n.getCreatedAt().format(formatterList));
            }
        }
        
        model.addAttribute("notices", list);
        return "notice/noticeListViewBO";
    }
	
    /**
     * 공지사항 상세 조회
     */
    @GetMapping("/{noticeId:[0-9]+}")
    public String noticeDetail(@PathVariable("noticeId") Long noticeId, Model model) {
    	
        Notice n = noticeService.noticeDetail(noticeId);
        DateTimeFormatter formatterDetail = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        n.setDetailDate(n.getCreatedAt().format(formatterDetail));
        
        model.addAttribute("notice", n);
        return "notice/noticeDetailBO";
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

//            System.out.println("[download] 최종 경로: " + file.getAbsolutePath());
//            System.out.println("[download] 존재 여부: " + file.exists());

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

}

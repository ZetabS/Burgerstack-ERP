package com.kh.burgerstack.notice;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.common.pagination.PagingRequest;

@Controller
@RequestMapping("/owner/notices")
public class OwnerNoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	/**
	 * 공지사항 목록 조회
	 * @param pagingRequest
	 * @param model
	 * @return
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
        return "notice/noticeListViewBO";
    }
	
	/**
	 * 공지사항 상세 조회
	 * @param noticeId
	 * @param model
	 * @return
	 */
	@GetMapping({"/{noticeId}", "{noticeId}"})
    public String noticeDetail(@PathVariable("noticeId") Long noticeId, Model model) {
        Notice n = noticeService.noticeDetail(noticeId);
        model.addAttribute("notice", n);
        return "notice/noticeDetailBO";
    }

}

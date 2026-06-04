package com.kh.burgerstack.notice;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.common.pagination.PagingRequest;
@Controller
@RequestMapping({ "/owner/notices", "/admin/notices" })
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("")
	public String selectNoticeList(PagingRequest pagingRequest, Model model) {
		int totalCount = noticeService.selectNoticeCount();
		
		model.addAttribute("pageInfo", pagingRequest.toPageInfo(totalCount));
		
		ArrayList<Notice> list = noticeService.selectNoticeList(pagingRequest);
		
		model.addAttribute("notices", list);
		System.out.println("totalCount : " + totalCount);
		System.out.println("list size :" + list.size());
		return "notice/noticeListView";
	} //selectNoticeList
}

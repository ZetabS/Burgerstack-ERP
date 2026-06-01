package com.kh.burgerstack.receipt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.burgerstack.common.pagination.model.dto.PageInfo;
import com.kh.burgerstack.common.pagination.model.dto.PagingRequest;
import com.kh.burgerstack.receipt.model.service.ReceiptService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("receipt")
public class ReceiptController {

	@Autowired
	private ReceiptService receiptService;
	
	@GetMapping("checkForm")
	public ModelAndView checkForm(ModelAndView mv) {
		
		// 우선 응답페이지를 만들어서 띄워보기
		mv.setViewName("receipt/receiptCheckForm");
		// > /WEB-INF/views/receipt/receiptForm.jsp
		
		return mv;
	}
	
	@GetMapping("history")
	public String history(PagingRequest pagingRequest, HttpServletRequest request, Model model) {
		PageInfo pageInfo = receiptService.getPageInfo(pagingRequest);

		if (pageInfo.isCurrentPageOutOfRange()) {
			return "redirect:receipt/receiptPlanList" + pageInfo.getLastAvailablePageQueryString(request.getQueryString());
		}

		model.addAttribute("pageInfo", pageInfo);


		// 우선 응답페이지를 만들어서 띄워보기
		return "receipt/receiptHistoryList";
		// > /WEB-INF/views/receipt/receiptHistoryList.jsp
	}
	
	@GetMapping("historyDetail")
	public ModelAndView historyDetail(ModelAndView mv) {
		
		// 우선 응답페이지를 만들어서 띄워보기
		mv.setViewName("receipt/receiptHistoryDetail");
		// > /WEB-INF/views/receipt/receiptHistoryDetail.jsp
		
		return mv;
	}
	
	@GetMapping("planned")
	public String planned(PagingRequest pagingRequest, HttpServletRequest request, Model model) {
		PageInfo pageInfo = receiptService.getPageInfo(pagingRequest);

		if (pageInfo.isCurrentPageOutOfRange()) {
			return "redirect:receipt/receiptPlanList" + pageInfo.getLastAvailablePageQueryString(request.getQueryString());
		}

		model.addAttribute("pageInfo", pageInfo);

		// 우선 응답페이지를 만들어서 띄워보기
		return "receipt/receiptPlanList";
		// mv.setViewName("receipt/receiptPlanList");
		// > /WEB-INF/views/receipt/receiptPlanList.jsp
		
		// return mv;
	}
	
}

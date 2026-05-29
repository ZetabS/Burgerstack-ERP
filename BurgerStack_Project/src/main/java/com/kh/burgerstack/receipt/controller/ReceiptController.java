package com.kh.burgerstack.receipt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("receipt")
public class ReceiptController {
	
	@GetMapping("checkForm")
	public ModelAndView checkForm(ModelAndView mv) {
		
		// 우선 응답페이지를 만들어서 띄워보기
		mv.setViewName("receipt/receiptCheckForm");
		// > /WEB-INF/views/receipt/receiptForm.jsp
		
		return mv;
	}
	
	@GetMapping("history")
	public ModelAndView history(ModelAndView mv) {
		
		// 우선 응답페이지를 만들어서 띄워보기
		mv.setViewName("receipt/receiptHistoryList");
		// > /WEB-INF/views/receipt/receiptHistoryList.jsp
		
		return mv;
	}
	
	@GetMapping("historyDetail")
	public ModelAndView historyDetail(ModelAndView mv) {
		
		// 우선 응답페이지를 만들어서 띄워보기
		mv.setViewName("receipt/receiptHistoryDetail");
		// > /WEB-INF/views/receipt/receiptHistoryDetail.jsp
		
		return mv;
	}
	
	@GetMapping("planned")
	public ModelAndView planned(ModelAndView mv) {
		
		// 우선 응답페이지를 만들어서 띄워보기
		mv.setViewName("receipt/receiptPlanList");
		// > /WEB-INF/views/receipt/receiptPlanList.jsp
		
		return mv;
	}
	
}

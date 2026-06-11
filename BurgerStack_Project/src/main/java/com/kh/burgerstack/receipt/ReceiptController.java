package com.kh.burgerstack.receipt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.common.pagination.PagingRequest;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ReceiptController {

    @Autowired
    private ReceiptService receiptService;

    // 입고 검수 등록 화면 - 점주
    @GetMapping("/owner/purchases/{purchaseId}/receipt")
    public ModelAndView checkForm(@PathVariable Long purchaseId,
                                  ModelAndView mv) {

        mv.addObject("purchaseId", purchaseId);
        mv.addObject("itemList", receiptService.selectReceiptCheckItemList(purchaseId));

        mv.setViewName("receipt/receiptCheckForm");

        return mv;
    }

    // 입고 이력 목록 조회 - 점주 / 관리자 공통
    @GetMapping({"/owner/receipts", "/admin/receipts"})
    public String history(PagingRequest pagingRequest,
                          HttpServletRequest request,
                          Model model) {

        PageInfo pageInfo = receiptService.getHistoryPageInfo(pagingRequest);

        if (pageInfo.isCurrentPageOutOfRange()) {

            if (request.getRequestURI().contains("/admin/")) {
                return "redirect:/admin/receipts"
                        + pageInfo.getLastAvailablePageQueryString(request.getQueryString());
            }

            return "redirect:/owner/receipts"
                    + pageInfo.getLastAvailablePageQueryString(request.getQueryString());
        }

        model.addAttribute("pageInfo", pageInfo);

        model.addAttribute("list",
                receiptService.selectReceiptList());

        if (request.getRequestURI().contains("/admin/")) {
            return "receipt/adminReceiptHistoryList";
        }

        return "receipt/receiptHistoryList";
    }

    // 입고 이력 상세 조회 - 점주 / 관리자 공통
    @GetMapping({"/owner/receipts/{receiptId}", "/admin/receipts/{receiptId}"})
    public ModelAndView historyDetail(@PathVariable Long receiptId,
                                      HttpServletRequest request,
                                      ModelAndView mv) {

        mv.addObject("receipt", receiptService.selectReceiptDetail(receiptId));
        mv.addObject("itemList", receiptService.selectReceiptItemDetailList(receiptId));

        if (request.getRequestURI().contains("/admin/")) {
            mv.setViewName("receipt/adminReceiptHistoryDetail");
        } else {
            mv.setViewName("receipt/receiptHistoryDetail");
        }

        return mv;
    }

	 	// 입고 예정 목록 조회 - 점주
	    @GetMapping("/owner/receipts/planned")
	    public String planned(@RequestParam(required = false, defaultValue = "") String status,
	                          PagingRequest pagingRequest,
	                          HttpServletRequest request,
	                          Model model) {
	
	        PageInfo pageInfo = receiptService.getPlanPageInfo(pagingRequest, status);
	
	        if (pageInfo.isCurrentPageOutOfRange()) {
	            return "redirect:/owner/receipts/planned?status=" + status;
	        }
	
	        model.addAttribute("pageInfo", pageInfo);
	        model.addAttribute("status", status);
	        model.addAttribute("list", receiptService.selectReceiptPlanList(pagingRequest, status));
	
	        return "receipt/receiptPlanList";
	    }
    
	 // 발주 입고 처리 - 점주
	    @PostMapping("/owner/purchases/{purchaseId}/receipt")
	    public String processReceipt(@PathVariable Long purchaseId,
	                                 ReceiptForm form) {
	
	        Long createdBy = 1L; // 로그인 붙기 전 임시 사용자 ID
	
	        receiptService.processReceipt(purchaseId, form, createdBy);
	
	        return "redirect:/owner/receipts";
    }
    
    
    
    
}

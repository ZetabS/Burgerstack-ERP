package com.kh.burgerstack.receipt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

        mv.addObject("receiptId", receiptId);

        if (request.getRequestURI().contains("/admin/")) {
            mv.setViewName("receipt/adminReceiptHistoryDetail");
        } else {
            mv.setViewName("receipt/receiptHistoryDetail");
        }

        return mv;
    }

    // 입고 예정 목록 조회 - 점주
    @GetMapping(value = "/owner/purchases", params = "status=APPROVED")
    public String planned(PagingRequest pagingRequest,
                          HttpServletRequest request,
                          Model model) {

        PageInfo pageInfo = receiptService.getPlanPageInfo(pagingRequest);

        if (pageInfo.isCurrentPageOutOfRange()) {
            return "redirect:/owner/purchases?status=APPROVED";
        }

        model.addAttribute("pageInfo", pageInfo);

        model.addAttribute("list",
                receiptService.selectReceiptPlanList(pagingRequest));

        return "receipt/receiptPlanList";
    }
}
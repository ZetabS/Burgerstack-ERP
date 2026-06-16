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
import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReceiptController {

    @Autowired
    private ReceiptService receiptService;

    // 입고 검수 등록 화면 - 점주
    // URL 변경:
    // 기존 /owner/purchases/{purchaseId}/receipt
    // 변경 /owner/receipts/{purchaseId}/receipt
    @GetMapping("/owner/receipts/{purchaseId}/receipt")
    public ModelAndView checkForm(@PathVariable Long purchaseId,
                                  ModelAndView mv) {

        mv.addObject("purchaseId", purchaseId);

        // APPROVED / PARTIALLY_APPROVED 상태를 JSP로 넘김
        mv.addObject("purchaseStatus",
                receiptService.selectPurchaseStatus(purchaseId));

        // 입고 처리 품목 목록
        mv.addObject("itemList",
                receiptService.selectReceiptCheckItemList(purchaseId));

        mv.setViewName("receipt/receiptCheckForm");

        return mv;
    }

    // 입고 이력 목록 조회 - 점주 / 관리자 공통
    @GetMapping({"/owner/receipts", "/admin/receipts"})
    public String history(@RequestParam(required = false, defaultValue = "") String receiptType,
                          @RequestParam(required = false, defaultValue = "") String startDate,
                          @RequestParam(required = false, defaultValue = "") String endDate,
                          @RequestParam(required = false, defaultValue = "") String keyword,
                          PagingRequest pagingRequest,
                          HttpServletRequest request,
                          Model model) {
        
        PageInfo pageInfo =
                receiptService.getHistoryPageInfo(
                        pagingRequest,
                        receiptType,
                        startDate,
                        endDate,
                        keyword
                );

        if (pageInfo.isCurrentPageOutOfRange()) {

            if (request.getRequestURI().contains("/admin/")) {
                return "redirect:/admin/receipts"
                        + pageInfo.getLastAvailablePageQueryString(request.getQueryString());
            }

            return "redirect:/owner/receipts"
                    + pageInfo.getLastAvailablePageQueryString(request.getQueryString());
        }

        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("receiptType", receiptType);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("keyword", keyword);

        model.addAttribute("list",
                receiptService.selectReceiptList(
                        pagingRequest,
                        receiptType,
                        startDate,
                        endDate,
                        keyword
                )
        );

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
                          @RequestParam(required = false, defaultValue = "") String startDate,
                          @RequestParam(required = false, defaultValue = "") String endDate,
                          @RequestParam(required = false, defaultValue = "") String keyword,
                          PagingRequest pagingRequest,
                          HttpServletRequest request,
                          Model model) {

        PageInfo pageInfo =
                receiptService.getPlanPageInfo(
                        pagingRequest,
                        status,
                        startDate,
                        endDate,
                        keyword
                );

        if (pageInfo.isCurrentPageOutOfRange()) {
            return "redirect:/owner/receipts/planned"
                    + pageInfo.getLastAvailablePageQueryString(request.getQueryString());
        }

        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("status", status);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("keyword", keyword);

        model.addAttribute("list",
                receiptService.selectReceiptPlanList(
                        pagingRequest,
                        status,
                        startDate,
                        endDate,
                        keyword
                )
        );

        return "receipt/receiptPlanList";
    }
    
    // 입고 처리 - 점주
    // URL 변경:
    // 기존 /owner/purchases/{purchaseId}/receipt
    // 변경 /owner/receipts/{purchaseId}/receipt
    @PostMapping("/owner/receipts/{purchaseId}/receipt")
    public String processReceipt(@PathVariable Long purchaseId,
                                 HttpSession session,
                                 ReceiptForm form) {

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        Long createdBy = loginUser.getUserNo();

        receiptService.processReceipt(purchaseId, form, createdBy);

        return "redirect:/owner/receipts";
    }

}
package com.kh.burgerstack.purchase;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.purchase.dto.PurchaseApprovalRequestDto;
import com.kh.burgerstack.purchase.dto.PurchaseDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderDetailDto;
import com.kh.burgerstack.purchase.dto.PurchaseSearchDto;

import jakarta.servlet.http.HttpSession;


/*
* ==================
*   관리자 컨트롤러
* ==================
*/


@Controller
@RequestMapping("admin")
public class PurchaseControllerHO {

    @Autowired
    private PurchaseService purchaseService;

    // 발주 목록
    @GetMapping("purchases")
    public String purchaseList(
        PagingRequest pagingRequest,
        PurchaseSearchDto condition, 
        HttpSession session,
        Model model){

        // 1. 발주 목록 조회
        ArrayList<PurchaseDto> list = purchaseService.searchPurchaseList(pagingRequest, condition, session);

        int totalCount = purchaseService.selectPurchaseCount(condition, session);

        PageInfo pageInfo = pagingRequest.toPageInfo(totalCount);
        
        // 2. Model에 담기
        model.addAttribute("list", list);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("condition", condition);

        // 3. View 지정
        return "purchase/purchaseListViewHO";
    }

    // 발주 상세보기
    @GetMapping("purchases/{id}")
    public ModelAndView purchaseDetail(
            @PathVariable("id") Long purchaseOrderId,
            ModelAndView mv
    ) {

        List<PurchaseOrderDetailDto> detail =
            purchaseService.getPurchaseOrderDetail(purchaseOrderId);

        mv.addObject("list", detail);
        mv.setViewName("purchase/purchaseDetailHO");

        return mv;
    }

    // 발주 승인 처리 페이지
    @GetMapping("purchases/{id}/approve")
    public ModelAndView processPurchase(
            @PathVariable("id") Long purchaseOrderId,
            ModelAndView mv) {

        List<PurchaseOrderDetailDto> list =
                purchaseService.getPurchaseOrderDetail(purchaseOrderId);

        mv.addObject("purchaseOrderId", purchaseOrderId);
        mv.addObject("list", list);

        mv.setViewName("purchase/purchaseApproveForm");

        return mv;
    }

    // 요청 발주 처리
    @PostMapping("purchases/{id}/approve")
    public String processPurchase(
            @PathVariable("id") Long purchaseOrderId,
            PurchaseApprovalRequestDto request
    ) {

        purchaseService.processPurchase(
                purchaseOrderId,
                request.getItems());

        return "redirect:/admin/purchases/" + purchaseOrderId;
    }

    // 취소 처리
    @PostMapping("purchases/{id}/cancel")
    public String cancelPurchase(@PathVariable("id") Long purchaseOrderId,
                                HttpSession session) {

        purchaseService.cancelPurchase(purchaseOrderId, session);

        return "redirect:/admin/purchases";
    }
    
}

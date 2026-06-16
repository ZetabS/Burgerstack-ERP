package com.kh.burgerstack.purchase;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.common.template.XssDefencePolicy;
import com.kh.burgerstack.purchase.dto.PurchaseApprovalItemDto;
import com.kh.burgerstack.purchase.dto.PurchaseApprovalRequestDto;
import com.kh.burgerstack.purchase.dto.PurchaseDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderDetailDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderDto;
import com.kh.burgerstack.purchase.dto.PurchaseSearchDto;
import com.kh.burgerstack.store.StoreDao;
import com.kh.burgerstack.store.StoreService;
import com.kh.burgerstack.store.dto.StoreOption;

import jakarta.servlet.http.HttpServletRequest;
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

    @Autowired
    private StoreDao storeDao;

    // 발주 목록
    @GetMapping({ "purchases"})
    public String purchaseList(
            @RequestParam(required = false) Long storeId,
            PurchaseSearchDto condition,
            PagingRequest pagingRequest,
            HttpSession session,
            HttpServletRequest request, // 요청 경로 확인을 위해 추가
            Model model) {

        // 1. 발주 목록 조회
        ArrayList<PurchaseDto> list = purchaseService.searchPurchaseList(pagingRequest, condition, session);

        List<StoreOption> storeOptions = storeDao.getStoreOptions();

        int totalCount = purchaseService.selectPurchaseCount(condition, session);

        PageInfo pageInfo = pagingRequest.toPageInfo(totalCount);

        // System.out.println("request storeId = " + storeId);
        // System.out.println("condition before = " + condition);

        condition.setStoreId(storeId);

        // System.out.println("condition after = " + condition);

        // 2. Model에 담기
        model.addAttribute("list", list);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("condition", condition);
        model.addAttribute("storeList", storeOptions);

        // 3. View 지정 (요청 경로에 따른 분기 처리)
        String requestURI = request.getRequestURI();
        if (requestURI.contains("/pending")) {
            return "purchase/purchaseApprovalList"; // 승인 대기 발주 페이지
        }
 
        return "purchase/purchaseListViewHO"; // 기존 발주 이력 목록 페이지
    }

    // 승인 대기 목록
    @GetMapping({"purchases/pending" })
    public String purchaseApprovalList(
            @RequestParam(required = false) Long storeId,
            PurchaseSearchDto condition,
            PagingRequest pagingRequest,
            HttpSession session,
            HttpServletRequest request, // 요청 경로 확인을 위해 추가
            Model model) {

        // 1. 발주 목록 조회
        ArrayList<PurchaseDto> list = purchaseService.searchPurchaseApprovalList(pagingRequest, condition, session);

        List<StoreOption> storeOptions = storeDao.getStoreOptions();

        int totalCount = purchaseService.selectPurchaseApprovalCount(condition, session);

        PageInfo pageInfo = pagingRequest.toPageInfo(totalCount);

        System.out.println("list size 11= " + list.size());
        System.out.println("totalCount 11= " + totalCount);

        // System.out.println("request storeId = " + storeId);
        // System.out.println("condition before = " + condition);

        condition.setStoreId(storeId);

        // System.out.println("condition after = " + condition);

        // 2. Model에 담기
        model.addAttribute("list", list);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("condition", condition);
        model.addAttribute("storeList", storeOptions);

        System.out.println("list size = " + list.size());
        System.out.println("totalCount = " + totalCount);

        // 3. View 지정 (요청 경로에 따른 분기 처리)
        String requestURI = request.getRequestURI();
        if (requestURI.contains("/pending")) {
            return "purchase/purchaseApprovalList"; // 승인 대기 발주 페이지
        }

        return "purchase/purchaseListViewHO"; // 기존 발주 이력 목록 페이지
    }

    // 발주 상세보기
    @GetMapping("purchases/{id}")
    public ModelAndView purchaseDetail(
            @PathVariable("id") Long purchaseOrderId,
            ModelAndView mv) {

        List<PurchaseOrderDetailDto> detail = purchaseService.getPurchaseOrderDetail(purchaseOrderId);

        PurchaseOrderDto storeInfo = purchaseService.selectPurchaseOrder(purchaseOrderId);

        mv.addObject("list", detail);
        mv.addObject("store", storeInfo);
        mv.setViewName("purchase/purchaseDetailHO");

        return mv;
    }

    // 발주 승인 처리 페이지
    @GetMapping("purchases/{id}/approve")
    public ModelAndView processPurchase(
            @PathVariable("id") Long purchaseOrderId,
            ModelAndView mv) {

        List<PurchaseOrderDetailDto> list = purchaseService.getPurchaseOrderDetail(purchaseOrderId);

        mv.addObject("purchaseOrderId", purchaseOrderId);
        mv.addObject("list", list);

        mv.setViewName("purchase/purchaseApproveForm");

        return mv;
    }

    // 요청 발주 처리
    @PostMapping("purchases/{id}/approve")
    public String processPurchase(
            @PathVariable("id") Long purchaseOrderId,
            PurchaseApprovalRequestDto request,
            @RequestParam(required = false) String bulkRejectReason) {

        // 전체 반려 사유 처리
        if (bulkRejectReason != null) {

            bulkRejectReason = bulkRejectReason.trim();

            if (bulkRejectReason.length() > 10) {
                throw new IllegalArgumentException("반려사유는 10자 이하만 가능합니다.");
            }

            if (!bulkRejectReason.isBlank()) {

                String safeReason = XssDefencePolicy.defence(bulkRejectReason);

                for (PurchaseApprovalItemDto item : request.getItems()) {
                    item.setRejectReason(safeReason);
                }
            }
        }

        // 승인수량과 요청수량이 다를 경우 반려사유 필수
        for (PurchaseApprovalItemDto item : request.getItems()) {

            if (item.getApprovedQuantity() != item.getRequestQuantity()
                    && (item.getRejectReason() == null
                            || item.getRejectReason().isBlank())) {

                throw new IllegalArgumentException(
                        "승인수량과 요청수량이 다른 품목은 반려사유를 반드시 입력해야 합니다.");
            }
        }

        // 검증 완료 후 처리
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

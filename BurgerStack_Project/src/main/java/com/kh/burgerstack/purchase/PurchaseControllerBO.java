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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.purchase.dto.MaterialInventoryDto;
import com.kh.burgerstack.purchase.dto.PurchaseDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderDetailDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderItemDto;
import com.kh.burgerstack.purchase.dto.PurchaseSearchDto;
import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpSession;
import tools.jackson.core.type.TypeReference;
import tools.jackson.databind.ObjectMapper;

/*
* ==================
*   점주 컨트롤러
* ==================
*/

@Controller
@RequestMapping("owner")
public class PurchaseControllerBO {

    @Autowired
    private PurchaseService purchaseService;

    // 발주 요청 페이지
    @GetMapping("purchases/new")
    public String purchaseCreate(Model model, HttpSession session) {

        ArrayList<MaterialInventoryDto> list = purchaseService.searchMaterialsList(session);

        // System.out.println(list);
        // for(MaterialInventoryDto mi : list) {
        // System.out.println(mi);
        // }

        model.addAttribute("list", list);

        // 우선 응답페이지를 만들어서 띄워보기
        // mv.setViewName("purchase/purchaseRequestForm");
        // > /WEB-INF/views/purchase/purchaseRequestForm.jsp

        return "purchase/purchaseRequestForm";
    }

    // 발주 목록
    @GetMapping("purchases")
    public String purchaseList(
            PagingRequest pagingRequest,
            PurchaseSearchDto condition,
            HttpSession session,
            Model model) {

        // 1. 발주 목록 조회
        ArrayList<PurchaseDto> list = purchaseService.searchPurchaseList(pagingRequest, condition, session);

        int totalCount = purchaseService.selectPurchaseCount(condition, session);

        PageInfo pageInfo = pagingRequest.toPageInfo(totalCount);

        // System.out.println(list);
        // for(PurchaseDto i : list) {
        // System.out.println(i);
        // }

        // 2. Model에 담기
        model.addAttribute("list", list);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("condition", condition);

        return "purchase/purchaseListViewBO";
        // > /WEB-INF/views/purchase/purchaseListViewBO.jsp
    }

    // 발주 처리
    @PostMapping("purchases")
    public String createPurchase(
            @RequestParam(required = false) String itemsJson,
            @RequestParam(required = false) String orderMemo,
            HttpSession session) throws Exception {

        if (itemsJson == null || itemsJson.isBlank()) {
            throw new IllegalArgumentException("선택된 발주 품목이 없습니다.");
        }

        ObjectMapper mapper = new ObjectMapper();

        List<PurchaseOrderItemDto> items = mapper.readValue(
                itemsJson,
                new TypeReference<List<PurchaseOrderItemDto>>() {
                });

        if (items.isEmpty()) {
            throw new IllegalArgumentException("선택된 발주 품목이 없습니다.");
        }

        for (PurchaseOrderItemDto item : items) {

            if (item.getRequestQuantity() > 1000) {
                throw new IllegalArgumentException(
                        "주문 수량은 1000개를 초과할 수 없습니다.");
            }

            if (item.getRequestQuantity() < 1) {
                throw new IllegalArgumentException(
                        "주문 수량은 1개 이상이어야 합니다.");
            }
        }

        purchaseService.createPurchase(items, orderMemo, session);

        return "redirect:/owner/purchases";
    }

    // 발주 상세보기
    @GetMapping("purchases/{id}")
    public ModelAndView purchaseDetail(
            @PathVariable("id") Long purchaseOrderId,
            ModelAndView mv) {

        List<PurchaseOrderDetailDto> detail = purchaseService.getPurchaseOrderDetail(purchaseOrderId);

        mv.addObject("list", detail);
        mv.setViewName("purchase/purchaseDetailBO");

        return mv;
    }

    // 수정 페이지 진입
    @GetMapping("purchases/{id}/edit")
    public ModelAndView editPurchase(
            @PathVariable Long id,
            HttpSession session,
            ModelAndView mv) {

        PurchaseDto purchase = purchaseService.getPurchaseForEdit(id);

        ArrayList<MaterialInventoryDto> materialList = purchaseService.searchMaterialsList(session);

        mv.addObject("purchase", purchase);
        mv.addObject("materialList", materialList);

        mv.setViewName("purchase/purchaseEditForm");

        return mv;
    }

    // 수정 처리
    @PostMapping("purchases/{id}/edit")
    public String updatePurchase(
            @PathVariable Long id,
            @RequestParam String itemsJson,
            HttpSession session) throws Exception {

        ObjectMapper mapper = new ObjectMapper();

        List<PurchaseOrderItemDto> items = mapper.readValue(itemsJson,
                new TypeReference<List<PurchaseOrderItemDto>>() {
                });

        purchaseService.updatePurchase(id, items, session);

        return "redirect:/owner/purchases/" + id;
    }

    // 취소 처리
    @PostMapping("purchases/{id}/cancel")
    public String cancelPurchase(@PathVariable("id") Long purchaseOrderId,
            HttpSession session) {

        purchaseService.cancelPurchase(purchaseOrderId, session);

        return "redirect:/owner/purchases";
    }

}

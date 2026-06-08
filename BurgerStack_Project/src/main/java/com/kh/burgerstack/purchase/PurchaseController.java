package com.kh.burgerstack.purchase;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.burgerstack.purchase.dto.MaterialInventoryDto;
import com.kh.burgerstack.purchase.dto.PurchaseDto;
import com.kh.burgerstack.purchase.dto.PurchaseOrderItemDto;

import jakarta.servlet.http.HttpSession;
import tools.jackson.core.type.TypeReference;
import tools.jackson.databind.ObjectMapper;



@Controller
@RequestMapping("owner")
public class PurchaseController {

    @Autowired
    private PurchaseService purchaseService;


	@GetMapping("purchases/new")
	public String purchaseCreate(Model model, HttpSession session) {

        ArrayList<MaterialInventoryDto> list = purchaseService.searchMaterialsList(session);
        
        // System.out.println(list);
		// for(MaterialInventoryDto mi : list) {
		// 	System.out.println(mi);
		// }

        model.addAttribute("list", list);

		// 우선 응답페이지를 만들어서 띄워보기
		// mv.setViewName("purchase/purchaseRequestForm");
		// > /WEB-INF/views/purchase/purchaseRequestForm.jsp

		return "purchase/purchaseRequestForm";
	}


    @GetMapping("purchases")
    public ModelAndView purchaseList(ModelAndView mv){


        // 1. 발주 목록 조회
        ArrayList<PurchaseDto> list = purchaseService.searchPurchaseList();


        // System.out.println(list);
		// for(PurchaseDto i : list) {
		// 	System.out.println(i);
		// }
        

        // 2. Model에 담기
        mv.addObject("list", list);

        // 3. View 지정
        mv.setViewName("purchase/purchaseListViewBO");
		// > /WEB-INF/views/purchase/purchaseListViewBO.jsp

        return mv;
    }

    @PostMapping("purchases")
    public String createPurchase(
            @RequestParam String itemsJson,
            HttpSession session
    ) throws Exception {

        ObjectMapper mapper = new ObjectMapper();

        List<PurchaseOrderItemDto> items =
                mapper.readValue(itemsJson,
                        new TypeReference<List<PurchaseOrderItemDto>>() {});

        purchaseService.createPurchase(items, session);

        return "redirect:/owner/purchases";
    }

    @GetMapping("purchases/1")
    // @GetMapping("purchases/{purchaseId}")
    public ModelAndView purchaseListDetail(ModelAndView mv){

        // 우선 응답페이지를 만들어서 띄워보기
		// mv.setViewName("purchase/purchaseRequestDetailHO");
        mv.setViewName("purchase/purchaseDetail");
		// > /WEB-INF/views/purchase/purchaseListViewBO.jsp

        return mv;
    }

}

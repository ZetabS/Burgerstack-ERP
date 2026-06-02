package com.kh.burgerstack.purchase;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.burgerstack.purchase.dto.MaterialInventoryDto;



@Controller
@RequestMapping("owner")
public class PurchaseController {

    @Autowired
    private PurchaseService purchaseService;


	@GetMapping("purchases/new")
	public String purchaseCreate(Model model) {

        ArrayList<MaterialInventoryDto> list = purchaseService.searchMaterialsList();
        
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

        // 우선 응답페이지를 만들어서 띄워보기
		mv.setViewName("purchase/purchaseListViewBO");
		// > /WEB-INF/views/purchase/purchaseListViewBO.jsp

        return mv;
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

package com.kh.burgerstack.purchase;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("owner")
public class PurchaseController {

    @Autowired
    private PurchaseService purchaseService;


	@GetMapping("purchases/new")
	public ModelAndView purchaseCreate(ModelAndView mv) {

        ArrayList<PurchaseRequest> list = purchaseService.searchMaterialsList();
        
        System.out.println(list);
		for(PurchaseRequest pr : list) {
			System.out.println(pr);
		}


		// 우선 응답페이지를 만들어서 띄워보기
		mv.setViewName("purchase/purchaseRequestForm");
		// > /WEB-INF/views/purchase/purchaseRequestForm.jsp

		return mv;
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

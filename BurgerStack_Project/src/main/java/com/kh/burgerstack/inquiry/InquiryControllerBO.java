package com.kh.burgerstack.inquiry;

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

import com.kh.burgerstack.user.LoginUser;
import com.kh.burgerstack.user.User;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("owner")
public class InquiryControllerBO {

	@Autowired
	private InquiryServiceBO inquiryServiceBO;
	
	@GetMapping("inquiries")
    public String InquiryList(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "condition", required = false) String condition,
            @RequestParam(value = "keyword", required = false) String keyword,
            HttpSession session, Model model) {

        Long storeId = ((LoginUser) session.getAttribute("loginUser")).getStoreId();
        int limit = 10;

        int totalCount = inquiryServiceBO.getTotalCount(storeId, condition, keyword);
        int maxPage = (int) Math.ceil((double) totalCount / limit);
        int startPage = (((page - 1) / 10) * 10) + 1;
        int endPage = startPage + 9;
        if(endPage > maxPage) endPage = maxPage;

        List<Inquiry> inquiryList = inquiryServiceBO.InquiryList(storeId, condition, keyword, page, limit);

        model.addAttribute("inquiryList", inquiryList);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("condition", condition);
        model.addAttribute("keyword", keyword);

        return "inquiry/inquiryListViewBO";
    }
	

	// 문의사항 등록 페이지
	@GetMapping("inquiries/new")
	public String InquiryEnrollPage() {
		return "inquiry/inquiryEnrollForm";
	}

	// 문의사항 등록 기능
	@PostMapping("inquiries/new")
	public String InquiryEnroll(Inquiry inquiry, HttpSession session) {

		LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

		System.out.println("1. 세션에서 꺼낸 loginUser 객체: " + loginUser);
		if (loginUser != null) {
			System.out.println("2. loginUser 안의 storeId 값: " + loginUser.getStoreId());
		}

		if (loginUser != null && loginUser.getStoreId() != null) {
			inquiry.setStoreId(loginUser.getStoreId());
		} else {
			return "redirect:/auth/login";
		}

		inquiryServiceBO.InquiryEnroll(inquiry);

		return "redirect:/owner/inquiries";
	}

	// 문의사항 상세 조회 페이지
	@GetMapping("inquiries/{inquiryId}")
	public String InquiryListDetail(@PathVariable String inquiryId, Model model) {
		System.out.println("받은 Id = " + inquiryId);
		
		Inquiry i = inquiryServiceBO.InquiryListDetail(inquiryId);
		
		System.out.println("조회 결과 = " + inquiryId);
		
		model.addAttribute("inquiry",i);
		
		return "inquiry/inquiryListDetailBO";
	}
	//문의사항 수정 페이지
	@GetMapping("inquiries/{inquiryId}/edit")
	public String InquiryListEdit(@PathVariable String inquiryId, Model model) {
		
		Inquiry i = inquiryServiceBO.InquiryListDetail(inquiryId);
		
		model.addAttribute("inquiry",i);
		
		return"inquiry/inquiryEditBO";
	}
	// 문의사항 수정 기능
	@PostMapping("inquiries/{inquiryId}")
	public ModelAndView InquiryEdit(Inquiry i, ModelAndView mv, HttpSession session) {
		
		i.setStoreId(((LoginUser)session.getAttribute("loginUser")).getStoreId());

		System.out.println("1. 세션에서 꺼낸 loginUser 객체: " + i);
		
		int result = inquiryServiceBO.InquiryEdit(i);
		
		if(result > 0) {
			System.out.println("1");
			
			session.setAttribute("Inquiry", i);
			
			session.setAttribute("alertMsg", "성공적으로 정보가 수정되었습니다.");
			
			mv.setViewName("redirect:/owner/inquiries");
			
		}else {
			
			System.out.println("2");
			mv.addObject("errorMsg", "정보 수정에 실패하였습니다.");
			mv.setViewName("redirect:/owner/inquiries");
			
		}
		
		return mv;
	}
	
	

}

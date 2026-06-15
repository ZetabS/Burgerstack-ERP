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

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("owner")
public class InquiryControllerBO {

	@Autowired
	private InquiryServiceBO inquiryServiceBO;
	
	// 점주 문의사항 목록 조회 페이지
	@GetMapping("inquiries")
    public String InquiryList(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "condition", defaultValue = "title") String condition,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "answerStatus", required = false) String answerStatus,
            HttpSession session,
            Model model) {

        Long storeId = ((LoginUser) session.getAttribute("loginUser")).getStoreId();

        int limit = 10;

        int totalCount = inquiryServiceBO.getTotalCount(storeId, condition, keyword, answerStatus);

        int maxPage = (int) Math.ceil((double) totalCount / limit);
        int startPage = (((page - 1) / 10) * 10) + 1;
        int endPage = startPage + 9;

        if(endPage > maxPage) {
            endPage = maxPage;
        }

        List<Inquiry> inquiryList = inquiryServiceBO.InquiryList(storeId, condition, keyword, answerStatus, page, limit);

        model.addAttribute("inquiryList", inquiryList);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("currentPage", page);

        model.addAttribute("condition", condition);
        model.addAttribute("keyword", keyword);
        model.addAttribute("answerStatus", answerStatus);

        return "inquiry/inquiryListViewBO";
    }
	

	// 문의사항 등록 페이지
	@GetMapping("inquiries/new")
	public String InquiryEnrollPage() {
		return "inquiry/inquiryEnrollForm";
	}

	// 문의사항 등록 기능
	@PostMapping("inquiries/new")
	public String InquiryEnroll(Inquiry inquiry,
	                            HttpSession session) {

	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

	    if(loginUser != null && loginUser.getStoreId() != null) {
	        inquiry.setStoreId(loginUser.getStoreId());
	    } else {
	        return "redirect:/auth/login";
	    }

	    inquiryServiceBO.InquiryEnroll(inquiry);

	    return "redirect:/owner/inquiries";
	}

	// 문의사항 상세 조회 페이지
	@GetMapping("inquiries/{inquiryId}")
	public String InquiryListDetail(@PathVariable long inquiryId, Model model) {

		System.out.println("받은 Id = " + inquiryId);
		
		Inquiry i = inquiryServiceBO.InquiryListDetail(inquiryId);
		
		System.out.println("조회 결과 = " + inquiryId);
		
		model.addAttribute("inquiry", i);

        // 상세 페이지에서 수정 버튼 URL 만들 때 사용
        model.addAttribute("inquiryId", inquiryId);
		
		return "inquiry/inquiryListDetailBO";
	}

	// 문의사항 수정 페이지
	@GetMapping("inquiries/{inquiryId}/edit")
	public String InquiryListEdit(@PathVariable long inquiryId, Model model) {
		
		Inquiry i = inquiryServiceBO.InquiryListDetail(inquiryId);
		
		model.addAttribute("inquiry", i);

        // 수정 페이지 form action, deleteUrl 만들 때 사용
        model.addAttribute("inquiryId", inquiryId);
		
		return "inquiry/inquiryEditBO";
	}

	// 문의사항 수정 기능
	@PostMapping("inquiries/{inquiryId}")
	public ModelAndView InquiryEdit(@PathVariable long inquiryId,
	                                Inquiry i,
	                                ModelAndView mv,
	                                HttpSession session) {
		
        // URL에서 받은 inquiryId를 Inquiry 객체에 세팅
        i.setInquiryId(inquiryId);

        // 로그인한 점주의 storeId 세팅
		i.setStoreId(((LoginUser)session.getAttribute("loginUser")).getStoreId());

		System.out.println("수정할 inquiryId = " + inquiryId);
		System.out.println("수정할 Inquiry 객체 = " + i);
		
		int result = inquiryServiceBO.InquiryEdit(i);
		
		if(result > 0) {
			System.out.println("문의사항 수정 성공");
			
			session.setAttribute("Inquiry", i);
			
			session.setAttribute("alertMsg", "성공적으로 정보가 수정되었습니다.");
			
			mv.setViewName("redirect:/owner/inquiries");
			
		} else {
			
			System.out.println("문의사항 수정 실패");
			mv.addObject("errorMsg", "정보 수정에 실패하였습니다.");
			mv.setViewName("redirect:/owner/inquiries");
			
		}
		
		return mv;
	}

	// 문의사항 삭제 기능
	@PostMapping("inquiries/{inquiryId}/delete")
	public String inquiryDelete(@PathVariable long inquiryId,
	                            Inquiry i,
	                            Model model,
	                            HttpSession session) {
		
		int result = inquiryServiceBO.InquiryDelete(inquiryId);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "성공적으로 삭제되었습니다.");
			return "redirect:/owner/inquiries";
			
		} else {
			model.addAttribute("errorMsg", "실패하였습니다.");
			return "common/errorPage";
			
		}
	}

}
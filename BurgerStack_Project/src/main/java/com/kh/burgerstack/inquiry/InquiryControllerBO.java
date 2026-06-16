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
			com.kh.burgerstack.common.pagination.PagingRequest pi,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "condition", required = false) String condition,
			@RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "answerStatus", required = false) String answerStatus,
			HttpSession session, Model model) {

		if (keyword != null) {
			keyword = org.springframework.web.util.HtmlUtils.htmlEscape(keyword);
		}		
		
		Long storeId = ((LoginUser) session.getAttribute("loginUser")).getStoreId();
		int limit = 10; 

        int totalCount = inquiryServiceBO.getTotalCount(storeId, condition, keyword, answerStatus);

		com.kh.burgerstack.common.pagination.PageInfo pageInfo = pi.toPageInfo(totalCount);

        List<Inquiry> inquiryList = inquiryServiceBO.InquiryList(storeId, condition, keyword, answerStatus, page, limit);

		java.util.Map<String, Object> view = new java.util.HashMap<>();
		view.put("pageInfo", pageInfo);

		model.addAttribute("inquiryList", inquiryList);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
        model.addAttribute("answerStatus", answerStatus);
		model.addAttribute("view", view); 

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

		    if (inquiry.getTitle() != null && inquiry.getTitle().length() > 100) {
		        session.setAttribute("alertMsg", "제목은 최대 100자까지 입력 가능합니다.");
		        return "redirect:/owner/inquiries/new";
		    }

		    if (inquiry.getContent() != null && inquiry.getContent().length() > 1000) {
		        session.setAttribute("alertMsg", "내용은 최대 1000자까지 입력 가능합니다.");
		        return "redirect:/owner/inquiries/new";
		    }
		    
		    if (inquiry.getTitle() != null) {
		        inquiry.setTitle(org.springframework.web.util.HtmlUtils.htmlEscape(inquiry.getTitle()));
		    }
		    if (inquiry.getContent() != null) {
		        inquiry.setContent(org.springframework.web.util.HtmlUtils.htmlEscape(inquiry.getContent()));
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
		public ModelAndView InquiryEdit(Inquiry i, ModelAndView mv, HttpSession session) {
			
		    // 1. 제목 글자 수 검증
		    if (i.getTitle() != null && i.getTitle().length() > 100) {
		        session.setAttribute("alertMsg", "제목은 최대 100자까지 입력 가능합니다.");
		        mv.setViewName("redirect:/owner/inquiries");
		        return mv; 
		    }

		    // 2. 내용 글자 수 검증
		    if (i.getContent() != null && i.getContent().length() > 1000) {
		        session.setAttribute("alertMsg", "내용은 최대 1000자까지 입력 가능합니다.");
		        mv.setViewName("redirect:/owner/inquiries");
		        return mv;
		    }

		    if (i.getTitle() != null) {
		        i.setTitle(org.springframework.web.util.HtmlUtils.htmlEscape(i.getTitle()));
		    }
		    if (i.getContent() != null) {
		        i.setContent(org.springframework.web.util.HtmlUtils.htmlEscape(i.getContent()));
		    }		    	
		    
		    Inquiry originalInquiry = inquiryServiceBO.InquiryListDetail(i.getInquiryId());
		    
		    if(originalInquiry != null && originalInquiry.getAnswerContent() != null && !originalInquiry.getAnswerContent().trim().isEmpty()) {
		    	session.setAttribute("alertMsg", "본사 답변이 완료된 문의사항은 수정할 수 없습니다.");
		    	mv.setViewName("redirect:/owner/inquiries");
		    	return mv;
		    }
		    
		    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		    if (loginUser != null) {
		        i.setStoreId(loginUser.getStoreId());
		    } else {
		        mv.setViewName("redirect:/auth/login");
		        return mv;
		    }

		    System.out.println("1. 세션에서 꺼낸 loginUser 객체: " + i);
		    
		    int result = inquiryServiceBO.InquiryEdit(i);
		    
		    if(result > 0) {
		        System.out.println("1");
		        session.setAttribute("Inquiry", i);
		        session.setAttribute("alertMsg", "성공적으로 정보가 수정되었습니다.");
		        mv.setViewName("redirect:/owner/inquiries");
		    } else {
		        System.out.println("2");
		        mv.addObject("errorMsg", "정보 수정에 실패하였습니다.");
		        mv.setViewName("redirect:/owner/inquiries");
		    }
		    
		    return mv;
		}
		
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

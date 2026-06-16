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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("admin")
public class InquiryControllerHO {
	
	@Autowired
	private InquiryServiceHO inquiryServiceHO;
	
	// 본사 문의사항 목록조회 페이지
	@GetMapping("inquiries")
    public String InquiryList(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "condition", required = false) String condition,
            @RequestParam(value = "keyword", required = false) String keyword,
            HttpSession session, Model model) {
		
        int limit = 10;

        int totalCount = inquiryServiceHO.getTotalCount(condition, keyword);
        int maxPage = (int) Math.ceil((double) totalCount / limit);
        int startPage = (((page - 1) / 10) * 10) + 1;
        int endPage = startPage + 9;
        if(endPage > maxPage) endPage = maxPage;

        List<Inquiry> inquiryList = inquiryServiceHO.InquiryList(condition, keyword, page, limit);

        model.addAttribute("inquiryList", inquiryList);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("condition", condition);
        model.addAttribute("keyword", keyword);

        return "inquiry/inquiryListViewHO";
    }
	// 본사 문의사항 상세 조회 페이지
	@GetMapping("inquiries/{inquiryId}")
	public String InquiryListDetail(@PathVariable long inquiryId, Model model) {

	    Inquiry inquiry = inquiryServiceHO.InquiryListDetail(inquiryId);
	    
	    System.out.println(
	    	    "[" + inquiry.getAnswerContent() + "]"
	    	);
	    
	    model.addAttribute("inquiry", inquiry);
		
		return"inquiry/inquiryListDetailHO";
	}
	// 본사 문의사항 수정 페이지
	@GetMapping("inquiries/{inquiryId}/edit")
	public String InquiryListEdit(@PathVariable long inquiryId, Model model) {
		
		Inquiry i = inquiryServiceHO.InquiryListDetail(inquiryId);
		
		model.addAttribute("inquiry",i);
		
		return"inquiry/inquiryEditHO";
	}

	// 문의사항 수정 기능
	@PostMapping("inquiries/{inquiryId}")
	public ModelAndView InquiryEdit(
	        @PathVariable Long inquiryId,
	        Inquiry i,
	        ModelAndView mv,
	        HttpSession session) {
		
	    System.out.println("inquiryId = " + inquiryId);
	    System.out.println("answerContent = " + i.getAnswerContent());

	    i.setInquiryId(inquiryId);

	    int result = inquiryServiceHO.InquiryEdit(i);

	    if(result > 0) {

	        session.setAttribute(
	            "alertMsg",
	            "답변이 성공적으로 수정되었습니다."
	        );

	        mv.setViewName(
	            "redirect:/admin/inquiries"
	        );

	    } else {

	        mv.addObject(
	            "errorMsg",
	            "답변 수정에 실패했습니다."
	        );

	        mv.setViewName(
	            "redirect:/admin/inquiries"
	        );
	    }

	    return mv;
	}

		@PostMapping("inquiries/{inquiryId}/delete")
		public String inquiryDelete(@PathVariable long inquiryId, Model model, HttpSession session) {
			
			int result = inquiryServiceHO.InquiryDelete(inquiryId);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "성공적으로 삭제되었습니다.");
				return "redirect:/admin/inquiries";
				
			}else {
				model.addAttribute("errorMsg", "실패하였습니다.");
				return "common/errorPage";
				
			}
		}

	
	

}

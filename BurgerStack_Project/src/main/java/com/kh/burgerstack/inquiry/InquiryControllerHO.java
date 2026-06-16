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

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("admin")
public class InquiryControllerHO {
	
	@Autowired
	private InquiryServiceHO inquiryServiceHO;
	
	// 본사 문의사항 목록조회 페이지
		@GetMapping("inquiries")
	    public String InquiryList(
	    		com.kh.burgerstack.common.pagination.PagingRequest pi,
	            @RequestParam(value = "page", defaultValue = "1") int page,
	            @RequestParam(value = "condition", required = false) String condition,
	            @RequestParam(value = "keyword", required = false) String keyword,
           		// 문의 필터 : 문의 필터, 전체, 답변전, 답변완료
            	@RequestParam(value = "answerStatus", required = false) String answerStatus,
	            HttpSession session, Model model) {
			
			if (keyword != null) {
		        keyword = org.springframework.web.util.HtmlUtils.htmlEscape(keyword);
		    }
			
	        int limit = 10;

        int totalCount = inquiryServiceHO.getTotalCount(condition, keyword, answerStatus);
	        
	        com.kh.burgerstack.common.pagination.PageInfo pageInfo = pi.toPageInfo(totalCount);

	        // 3. 목록 데이터 조회
	        List<Inquiry> inquiryList = inquiryServiceHO.InquiryList(condition, keyword, answerStatus, page, limit);

	        model.addAttribute("inquiryList", inquiryList);
	        model.addAttribute("pageInfo", pageInfo); 
	        model.addAttribute("condition", condition);
	        model.addAttribute("keyword", keyword);
		    // 문의 필터 선택값 유지용 데이터
        	model.addAttribute("answerStatus", answerStatus);

	        return "inquiry/inquiryListViewHO";
	    }
		
	// 본사 문의사항 상세 조회 페이지
	@GetMapping("inquiries/{inquiryId}")
	public String InquiryListDetail(@PathVariable long inquiryId, Model model) {

	    // 문의사항 상세 정보 조회
	    Inquiry inquiry = inquiryServiceHO.InquiryListDetail(inquiryId);
	    
	    // 답변 내용 확인용 로그
	    System.out.println(
	    	    "[" + inquiry.getAnswerContent() + "]"
	    	);
	    
	    // 상세 페이지에서 출력할 문의사항 객체
	    model.addAttribute("inquiry", inquiry);

        // 수정 버튼 URL 생성 시 사용할 문의사항 번호
        // JSP에서 ${inquiryId}로 사용할 수 있습니다.
        model.addAttribute("inquiryId", inquiryId);
		
		return "inquiry/inquiryListDetailHO";
	}

	// 본사 문의사항 수정 페이지
	@GetMapping("inquiries/{inquiryId}/edit")
	public String InquiryListEdit(@PathVariable long inquiryId, Model model) {
		
        // 수정 화면에 보여줄 문의사항 상세 정보 조회
		Inquiry i = inquiryServiceHO.InquiryListDetail(inquiryId);
		
        // 수정 화면에서 사용할 문의사항 객체
		model.addAttribute("inquiry", i);

        // 수정 form action 또는 hidden 값에서 사용할 문의사항 번호
        model.addAttribute("inquiryId", inquiryId);
		
		return "inquiry/inquiryEditHO";
	}

	// 문의사항 답변 수정 기능
	@PostMapping("inquiries/{inquiryId}")
	public ModelAndView InquiryEdit(
	        // URL에 포함된 문의사항 번호
	        @PathVariable Long inquiryId,

	        // 수정 폼에서 넘어온 답변 데이터
	        Inquiry i,

	        ModelAndView mv,
	        HttpSession session) {

	    // 1. 내용 글자 수 검증
	    if (i.getAnswerContent() != null && i.getAnswerContent().length() > 1000) {
	        session.setAttribute("alertMsg", "내용은 최대 1000자까지 입력 가능합니다.");
	        mv.setViewName("redirect:/admin/inquiries");
	        return mv;
	    }

	    if (i.getAnswerContent() != null) {
	        String safeContent = org.springframework.web.util.HtmlUtils.htmlEscape(i.getAnswerContent());
	        i.setAnswerContent(safeContent);
	    }

        // URL의 inquiryId를 Inquiry 객체에 직접 세팅
	    i.setInquiryId(inquiryId);

        // 답변 수정 처리
	    int result = inquiryServiceHO.InquiryEdit(i);

	    if(result > 0) {

            // 성공 메시지
	        session.setAttribute(
	            "alertMsg",
	            "답변이 성공적으로 수정되었습니다."
	        );

            // 수정 성공 후 본사 문의사항 목록으로 이동
	        mv.setViewName(
	            "redirect:/admin/inquiries"
	        );

	    } else {

            // 실패 메시지
	        mv.addObject(
	            "errorMsg",
	            "답변 수정에 실패했습니다."
	        );

            // 실패해도 목록으로 이동
	        mv.setViewName(
	            "redirect:/admin/inquiries"
	        );
	    }

	    return mv;
	}

	// 본사 문의사항 답변 삭제 기능
	@PostMapping("inquiries/{inquiryId}/delete")
	public String inquiryDelete(@PathVariable long inquiryId, Model model, HttpSession session) {
		
        // 답변 삭제 처리
		int result = inquiryServiceHO.InquiryDelete(inquiryId);
		
		if(result > 0) {

            // 삭제 성공 메시지
			session.setAttribute("alertMsg", "성공적으로 삭제되었습니다.");

            // 삭제 성공 후 본사 문의사항 목록으로 이동
			return "redirect:/admin/inquiries";
			
		} else {

            // 삭제 실패 시 에러 페이지 이동
			model.addAttribute("errorMsg", "실패하였습니다.");
			return "common/errorPage";
		}
	}

}

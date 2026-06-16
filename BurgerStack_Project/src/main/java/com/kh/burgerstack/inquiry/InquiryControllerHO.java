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
	public ModelAndView InquiryEdit(@PathVariable Long inquiryId, Inquiry i, ModelAndView mv, HttpSession session) {

	    // 1. 내용 글자 수 검증
	    if (i.getAnswerContent() != null && i.getAnswerContent().length() > 1000) {
	        session.setAttribute("alertMsg", "내용은 최대 1000자까지 입력 가능합니다.");
	        mv.setViewName("redirect:/admin/inquiries");
	        return mv;
	    }

	    // 2. 기존 데이터 조회 (중요: 답변이 이미 있었는지 확인하기 위함)
	    Inquiry existingInquiry = inquiryServiceHO.InquiryListDetail(inquiryId);
	    
	    // 3. 답변 여부 판단 (기존 답변 내용이 null이거나 비어있으면 "작성", 아니면 "수정")
	    boolean isNewAnswer = (existingInquiry.getAnswerContent() == null || existingInquiry.getAnswerContent().trim().isEmpty());

	    // 4. 보안 처리 및 데이터 세팅
	    if (i.getAnswerContent() != null) {
	        i.setAnswerContent(org.springframework.web.util.HtmlUtils.htmlEscape(i.getAnswerContent()));
	    }
	    i.setInquiryId(inquiryId);

	    // 5. 답변 수정/작성 서비스 호출
	    int result = inquiryServiceHO.InquiryEdit(i);

	    if(result > 0) {
	        // 성공 시 판단 로직 적용
	        String msg = isNewAnswer ? "답변이 성공적으로 작성되었습니다." : "답변이 성공적으로 수정되었습니다.";
	        session.setAttribute("alertMsg", msg);
	        mv.setViewName("redirect:/admin/inquiries");
	    } else {
	        mv.addObject("errorMsg", "답변 처리에 실패했습니다.");
	        mv.setViewName("redirect:/admin/inquiries");
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

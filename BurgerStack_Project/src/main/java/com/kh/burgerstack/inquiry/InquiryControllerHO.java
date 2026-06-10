package com.kh.burgerstack.inquiry;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("admin")
public class InquiryControllerHO {
	
	@Autowired
	private InquiryServiceHO inquiryServiceHO;
	
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
	
	

}

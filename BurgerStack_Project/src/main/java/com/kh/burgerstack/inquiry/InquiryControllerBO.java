package com.kh.burgerstack.inquiry;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("owner")
public class InquiryControllerBO {
	
	@GetMapping("inquiries")
	public String InquiryList(){
		
		return "inquiry/inquiryListViewBO";
	}
	
	@GetMapping("inquiries/new")
	public String InquiryEnrollPage() {
		return "inquiry/inquiryEnrollForm";
	}
	@PostMapping("inquiries/new")
	public String InquiryEnroll() {
		
		return "user/dashboard";
	}

}

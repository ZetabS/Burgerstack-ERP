package com.kh.burgerstack.inquiry;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin")
public class InquiryControllerHO {
	
	@GetMapping("inquiries")
	public String InquiryList(){
		
		return "inquiry/inquiryListViewHO";
	}

}

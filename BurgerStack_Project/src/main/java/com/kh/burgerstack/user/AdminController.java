package com.kh.burgerstack.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin")
public class AdminController {

	@GetMapping("mypage")
	public String MyPageHo() {
		return "user/MyPageHO";
	}
	
	@PostMapping("changePassword")
	public String changePassword() {
		
		return "user/MyPageBO";
	}
	
	@GetMapping("homebutton")
	public String homeButton() {
		
		return "user/dachboardHO";
	}
	
	@GetMapping("dashboardHO")
	public String dashboardHo() {
		return "user/dashboardHO";
	}
	
}

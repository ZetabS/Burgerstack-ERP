package com.kh.burgerstack.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("admin")
public class MyPageHOController {

	@GetMapping("mypage")
	public String MyPageHo() {
		return "user/MyPageHO";
	}
	
	@PostMapping("changePassword")
	public String changPassword() {
		
		return "user/MyPageBO";
	}
	
	@PostMapping("changePassword")
	public String changePassword() {
		
		return "user/MyPageBO";
	}
	
	@GetMapping("homebutton")
	public String homeButton() {
		
		return "user/dachboardHO";
	}
	
//	@PostMapping("insertStoreOwner")
//	public String insertStoreOwner(User u, Model model, HttpSession session) {
//		
//		String encPwd = bCryptPasswordEncoder.encode(u.getPassword());
//		
//		u.setPassword(
//				bCryptPasswordEncoder.encode(u.getPassword())
//		);
//
//		int result = userService.insertStoreOwner(u);
//		
//		if(result > 0) {
//		    session.setAttribute("alertMsg", "계정이 등록되었습니다.");
//		    
//		    return "redirect:/user/MyPageHO";
//		} else {
//			model.addAttribute("errorMsg", "회원가입에 실패했습니다");
//			return "common/errorPage";
//			
//		}
//    }
	
}

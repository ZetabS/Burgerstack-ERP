package com.kh.burgerstack.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.user.model.service.LoginService;
import com.kh.burgerstack.user.model.vo.User;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("user")
public class LoginController {

	@PostMapping("login")
	public void loginUer(User u, Model model) {
		
		User loginUser = LoginService.loginUser(u);
		
		if((loginUser != null) &&
			()) {
			
			model.addAttribute("errorMsg", "로그인에 실패했습니다.");
			
			return "common/errorPage";
			
		}else {
		
			
			session.setAttribute("loginUser", loginUser);
			
			session.setAttribute("alertMsg", "성공적으로 로그인이 되었습니다.");
			
			return "redirect:/";
			
		}
		
	}
	
	@GetMapping('logout')
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginUser");

		session.setAttribute("alertMsg", "성공적으로 로그아웃이 되었습니다.");
		
		return "redirect/";
		
	}
	
	@GetMapping("/mypage")
	public String mypage(Model model) {

	    User user = new User();

	    user.setUserId("kangnamh");
	    user.setUserName("유종규");
	    user.setPhone("010-1111-2222");
	    user.setEmail("dbwhdrb1@gmail.com");

	    model.addAttribute("loginUser", user);

	    return "mypage";
	}
}

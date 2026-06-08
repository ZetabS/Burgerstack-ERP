package com.kh.burgerstack.user;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("auth")
public class LoginController {

	@Autowired
	private LoginService loginService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@GetMapping("login")
	public String loginUser() {
		

		return "user/loginForm";
		
	}
	
	@ResponseBody
	@PostMapping("login")
	public Map<String, Object> login(String userId, String password,
									 HttpSession session) {
		
		LoginUser loginUser = loginService.login(userId);
		
		if((loginUser == null)||
				(!bCryptPasswordEncoder.matches(password, loginUser.getPassword()))) {
			return Map.of("success", false,
						  "message", "아이디 또는 비밀번호가 일치하지 않습니다.");
			
		}
		
		session.setAttribute("loginUser", loginUser);
		
		if("ADMIN".equals(loginUser.getRole())) {
		    return Map.of(
		            "success", true,
		            "redirectUrl", "/burgerstack/admin/dashboard");
		}

		
		return Map.of("success", true,
					  "redirectUrl","/burgerstack/owner/dashboard");
	}
	
	@GetMapping("logout")
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginUser");
		
		return "redirect:login";
		
	}
	@GetMapping("loginErrorPage")
	public String userErrorPage() {
		return "user/loginErrorPage";
	}
	
}

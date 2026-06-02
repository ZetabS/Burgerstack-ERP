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
@RequestMapping("user")
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
	public Map<String, Object> login(String loginId, String password,
									 HttpSession session) {
		
		LoginUser loginUser = loginService.login(loginId);
		System.out.println(loginId);
		System.out.println(password);
		System.out.println(bCryptPasswordEncoder.encode(password));
		
		if((loginUser == null)||
				(!bCryptPasswordEncoder.matches(password, loginUser.getPassword()))) {
			return Map.of("success", false,
						  "message", "아이디 또는 비밀번호가 일치하지 않습니다.");
			
		}
		
		session.setAttribute("loginUser", loginUser);
		
		return Map.of("success", true,
					  "redirectUrl","/burgerstack");
	}
	
//	
//	@GetMapping("logout")
//	public String logoutMember(HttpSession session) {
//		
//		session.removeAttribute("loginUser");
//
//		session.setAttribute("alertMsg", "성공적으로 로그아웃이 되었습니다.");
//		
//		return "redirect/";
//		
//	}
//	
//	@GetMapping("/mypage")
//	public String mypage(Model model) {
//		
//	    User user = new User();
//
//	    user.setUserId("kangnamh");
//	    user.setUserName("유종규");
//	    user.setPhone("010-1111-2222");
//	    user.setEmail("dbwhdrb1@gmail.com");
//
//	    model.addAttribute("loginUser", user);
//
//	    return "mypage";
//	}
}

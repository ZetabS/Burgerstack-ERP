package com.kh.burgerstack.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("auth")
public class UserController {
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private UserService userService;
	
	@PostMapping("enroll")
	public String storeOwnerEnroll(User u, Model model, HttpSession session) {
	    
	    if (u.getUserName() != null) u.setUserName(org.springframework.web.util.HtmlUtils.htmlEscape(u.getUserName()));
	    if (u.getEmail() != null) u.setEmail(org.springframework.web.util.HtmlUtils.htmlEscape(u.getEmail()));
	    if (u.getPhone() != null) u.setPhone(org.springframework.web.util.HtmlUtils.htmlEscape(u.getPhone()));
	    
	    String encPwd = bCryptPasswordEncoder.encode(u.getPassword());
	    u.setPassword(encPwd);
	    
	    return "redirect:/auth/login";
	}
	
	
}

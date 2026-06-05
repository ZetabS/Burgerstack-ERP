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
	
	@GetMapping("enrollForm")
	public String storeOwnerEnrollForm() {
		
		return "user/userEnrollForm";
	}
	
	@PostMapping("insertStoreOwner")
	public String insertStoreOwner(User u, Model model, HttpSession session) {
		
		String encPwd = bCryptPasswordEncoder.encode(u.getPassword());
		
		u.setPassword(
				bCryptPasswordEncoder.encode(u.getPassword())
		);

		int result = userService.insertStoreOwner(u);
		
		if(result > 0) {
		    session.setAttribute("alertMsg", "계정이 등록되었습니다.");
		    
		    return "redirect:/admin/MyPageHO";
		} else {
			model.addAttribute("errorMsg", "회원가입에 실패했습니다");
			return "common/errorPage";
			
		}
    } 
	
	
	
}

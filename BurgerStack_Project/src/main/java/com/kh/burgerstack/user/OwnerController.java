package com.kh.burgerstack.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("owner")
public class OwnerController {
	
	@Autowired
	private OwnerService ownerService;

	@GetMapping("mypage")
	public String MyPageBo() {
		return "user/MyPageBO";
	}
	
	@PostMapping("update")
	public ModelAndView update(User u, ModelAndView mv ,HttpSession session) {
		
		int result = ownerService.update(u);
		
		if(result > 0) {
			
			session.setAttribute("User", u);
			
			session.setAttribute("alertMsg", "성공적으로 정보가 수정되었습니다.");
			
			mv.setViewName("redirect:/user/MyPageBO");
			
		}else {
			
			
			
			mv.addObject("errorMsg", "정보 수정에 실패하였습니다.");
			
		}
		
		
	}
	
	@PostMapping("updatePassword")
	public String updatePassword() {
		
		
		return "user/MyPageBO";
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
//		    return "redirect:/admin/MyPageHO";
//		} else {
//			model.addAttribute("errorMsg", "회원가입에 실패했습니다");
//			return "common/errorPage";
//			
//		}
//    } 
	
	@GetMapping("homebutton")
	public String homeButton() {
		
		return "user/dashboardBO";
	}
	
	@GetMapping("dashboardBO")
	public String dashboardBo() {
		return "user/dashboardBO";
	}
	
}

package com.kh.burgerstack.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
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
		
		return mv;
	}
	
	@PostMapping("updatePassword")
	public String updatePassword(String currentPwd, String newPwd, 
						String checkedPwd, HttpSession session) {
		
		User loginUser = (User)(session.getAttribute("loginUser"));
		
		if(bCryptPasswordEncoder.matches(currentPwd, loginUser.getPassword())) {
			
			session.setAttribute("alertMsg", "현재 비밀번호와 일치하지 않습니다.");
			
			return "redirect:/user/MyPageBO";
		}

		if(!newPwd.equals(checkedPwd)) {
			
			session.setAttribute("alertMsg", "새 비밀번호와 일치하지 않습니다. 비밀번호 확인을 다시 해주십시오.");
			
			return "redirect:/user/MyPageBO";
			
		}
		
		String encPwd = bCryptPasswordEncoder.encode(newPwd);
		
		User u = new User();
		u.setUserNo(loginUser.getUserNo());
		u.setPassword(encPwd);
		
		int result = ownerService.updatePassword(u);
		
		if(result > 0) {
			
			loginUser.setPassword(encPwd);
			
			session.setAttribute("loginUser", loginUser);
			
			session.setAttribute("alertMsg", "비밀번호가 변경되었습니다.");
			
		}else{
			
			session.setAttribute("errorMsg", "비밀번호 변경에 실패하였습니다.");
			
		}
		
		return "redirect:/user/MyPageBO";
	}
	
	@GetMapping("homebutton")
	public String homeButton() {
		
		return "user/dashboardBO";
	}
	
	@GetMapping("dashboardBO")
	public String dashboardBo() {
		return "user/dashboardBO";
	}
	
}

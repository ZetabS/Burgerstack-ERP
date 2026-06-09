package com.kh.burgerstack.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("admin")
public class AdminController {

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	private AdminService adminService;

	@GetMapping("mypage")
	public String MyPageHO() {
		return "user/MyPageHO";
	}
	
	@GetMapping("users/new")
	public String New() {
		return "user/New";
	}
	@PostMapping("users")
	public String NewOwner(User u, Model model, HttpSession session) {
			
	    System.out.println("===== 등록 요청 =====");
	    System.out.println(u);
		
			String encPwd = bCryptPasswordEncoder.encode(u.getPassword());
			
			u.setPassword(
					bCryptPasswordEncoder.encode(u.getPassword())
			);

			int result = adminService.NewOwner(u);
			
			if(result > 0) {
			    session.setAttribute("alertMsg", "계정이 등록되었습니다.");
			    
			    return "redirect:/admin/dashboard";
			} else {
				model.addAttribute("errorMsg", "계정 등록에 실패했습니다");
				return "common/errorPage";
				
			}
	}
	
	@PostMapping("mypage")
	public ModelAndView update(User u, ModelAndView mv, HttpSession session) {
		
		u.setUserNo(((LoginUser)session.getAttribute("loginUser")).getUserNo());
		
		int result = adminService.update(u);

		if (result > 0) {
			
			System.out.println("1");
			
			session.setAttribute("User", u);

			session.setAttribute("alertMsg", "성공적으로 정보가 수정되었습니다.");

			mv.setViewName("redirect:/admin/dashboard");

		} else {
			System.out.println("2");
			mv.addObject("errorMsg", "정보 수정에 실패하였습니다.");
			mv.setViewName("common/mypage");
		}

		return mv;
	}

	@PostMapping("updatePassword")
	public String updatePassword(String currentPwd, String newPwd, String checkedPwd, HttpSession session) {

		User loginUser = (User)(session.getAttribute("loginUser"));

		if (bCryptPasswordEncoder.matches(currentPwd, loginUser.getPassword())) {

			session.setAttribute("alertMsg", "현재 비밀번호와 일치하지 않습니다.");

			return "redirect:/admin/mypage";
		}

		if (!newPwd.equals(checkedPwd)) {

			session.setAttribute("alertMsg", "새 비밀번호와 일치하지 않습니다. 비밀번호 확인을 다시 해주십시오.");

			return "redirect:/admin/mypage";

		}

		String encPwd = bCryptPasswordEncoder.encode(newPwd);

		User u = new User();
		u.setUserNo(loginUser.getUserNo());
		u.setPassword(encPwd);

		int result = adminService.updatePassword(u);

		if (result > 0) {

			loginUser.setPassword(encPwd);

			session.setAttribute("loginUser", loginUser);

			session.setAttribute("alertMsg", "비밀번호가 변경되었습니다.");

		} else {

			session.setAttribute("errorMsg", "비밀번호 변경에 실패하였습니다.");

		}

		return "redirect:/admin/mypage";
	}

	@GetMapping("homebutton")
	public String homeButton() {

		return "user/dashboardHO";
	}

	@GetMapping("dashboard")
	public String dashboardHO() {
		return "user/dashboardHO";
	}

	@GetMapping("users")
	public String OwnerList(Model model) {
		
		List<User> ownerList = adminService.OwnerList();
		
		model.addAttribute("ownerList",ownerList);
		
		return "user/OwnerList";
	}
	
	@GetMapping("users/{userId}")
	public String OwnerListDetail(@PathVariable String userId, Model model) {
		System.out.println("받은 userId = " + userId);
		
		User user = adminService.OwnerListDetail(userId);
		
		System.out.println("조회 결과 = " + user);
		model.addAttribute("user", user);
		
		return "user/OwnerListDetail";
	}
	@GetMapping("users/{userId}/edit")
	public String OwnerListEdit(
	        @PathVariable String userId,
	        Model model) {

	    User user = adminService.OwnerListDetail(userId);

	    model.addAttribute("user", user);

	    return "user/OwnerListEdit";
	}
	@PostMapping("users/{userId}")
	public String OwnerUpdate(@PathVariable String userId, User user, HttpSession session) {
		
		user.setUserId(userId);
		
		if(user.getPassword() != null &&
				!user.getPassword().trim().isEmpty()){
				
			user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
			
		}else{
			user.setPassword(null);
		}
		
		int result = adminService.OwnerUpdate(user);
		
		if(result > 0) {
	        session.setAttribute("alertMsg", "점주 정보가 수정되었습니다.");
	        return "redirect:/admin/users/" + userId;
		}
		return"common/errorPage";
	}
}

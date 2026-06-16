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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.burgerstack.inquiry.Inquiry;

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

	    if (u.getUserName() != null) u.setUserName(org.springframework.web.util.HtmlUtils.htmlEscape(u.getUserName()));
	    if (u.getEmail() != null) u.setEmail(org.springframework.web.util.HtmlUtils.htmlEscape(u.getEmail()));
	    if (u.getPhone() != null) u.setPhone(org.springframework.web.util.HtmlUtils.htmlEscape(u.getPhone()));

	    String encPwd = bCryptPasswordEncoder.encode(u.getPassword());
	    u.setPassword(encPwd);

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
		
		if (u.getUserName() != null) u.setUserName(org.springframework.web.util.HtmlUtils.htmlEscape(u.getUserName()));
	    if (u.getEmail() != null) u.setEmail(org.springframework.web.util.HtmlUtils.htmlEscape(u.getEmail()));
	    if (u.getPhone() != null) u.setPhone(org.springframework.web.util.HtmlUtils.htmlEscape(u.getPhone()));
		
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

	@GetMapping("users")
	public String OwnerList(
			// 🚨 1. 페이징을 자동으로 처리해줄 PagingRequest 객체를 맨 앞에 추가합니다.
			com.kh.burgerstack.common.pagination.PagingRequest pi,
			@RequestParam(value = "page", defaultValue = "1") int page, // 현재 페이지 번호 안전장치
			String status,
			String keyword,
			Model model) {

		if (keyword != null) {
			keyword = org.springframework.web.util.HtmlUtils.htmlEscape(keyword);
		}

		System.out.println("status = " + status);
		System.out.println("keyword = " + keyword);

		// 🚨 2. [필수 추가] 페이징 계산을 위해 먼저 검색 조건에 맞는 '전체 점주 수'를 조회해야 합니다.
		// (만약 adminService에 이 메서드가 없다면 뒤이어 나오는 '💡 서비스/매퍼 체크'를 확인해 주세요!)
		int totalCount = adminService.getOwnerCount(status, keyword); 

		// 🚨 3. 프로젝트 공통 규격으로 PageInfo 객체 생성
		com.kh.burgerstack.common.pagination.PageInfo pageInfo = pi.toPageInfo(totalCount);

		// 🚨 4. 목록 조회 시 페이징 정보(pi 또는 page, limit)를 서비스단으로 넘겨주어야 합니다.
		// (보통 프로젝트 구조상 pi를 통째로 넘기거나, page와 limit을 따로 넘깁니다. 여기서는 pi를 넘기는 규격으로 작성했습니다.)
		List<User> ownerList = adminService.OwnerList(status, keyword, pi);
		
		// 5. 화면(JSP)으로 데이터 수송
		model.addAttribute("keyword", keyword);
		model.addAttribute("status", status);
		model.addAttribute("ownerList", ownerList);
		model.addAttribute("pageInfo", pageInfo); // ✨ <t:pagination pageInfo="${pageInfo}" /> 가 정상 작동합니다.

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
		
		if (user.getUserName() != null) user.setUserName(org.springframework.web.util.HtmlUtils.htmlEscape(user.getUserName()));
	    if (user.getEmail() != null) user.setEmail(org.springframework.web.util.HtmlUtils.htmlEscape(user.getEmail()));
	    if (user.getPhone() != null) user.setPhone(org.springframework.web.util.HtmlUtils.htmlEscape(user.getPhone()));
	    
	    if(user.getPassword() != null && !user.getPassword().trim().isEmpty()){
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

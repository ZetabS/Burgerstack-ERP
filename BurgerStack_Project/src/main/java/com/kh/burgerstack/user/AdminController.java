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

	// 관리자 마이페이지
	@GetMapping("mypage")
	public String MyPageHO() {
		return "user/MyPageHO";
	}
	
	// 점주 계정 등록 페이지
	@GetMapping("users/new")
	public String New() {
		return "user/New";
	}

	// 점주 계정 등록 기능
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
	
	// 관리자 마이페이지 정보 수정
	@PostMapping("mypage")
	public ModelAndView update(User u, ModelAndView mv, HttpSession session) {
		
		if (u.getUserName() != null) u.setUserName(org.springframework.web.util.HtmlUtils.htmlEscape(u.getUserName()));
	    if (u.getEmail() != null) u.setEmail(org.springframework.web.util.HtmlUtils.htmlEscape(u.getEmail()));
	    if (u.getPhone() != null) u.setPhone(org.springframework.web.util.HtmlUtils.htmlEscape(u.getPhone()));
		
		u.setUserNo(((LoginUser)session.getAttribute("loginUser")).getUserNo());
		
		int result = adminService.update(u);

		if (result > 0) {
			
			System.out.println("관리자 정보 수정 성공");
			
			session.setAttribute("User", u);

			session.setAttribute("alertMsg", "성공적으로 정보가 수정되었습니다.");

			mv.setViewName("redirect:/admin/dashboard");

		} else {
			System.out.println("관리자 정보 수정 실패");
			mv.addObject("errorMsg", "정보 수정에 실패하였습니다.");
			mv.setViewName("common/mypage");
		}

		return mv;
	}

	// 관리자 비밀번호 변경
	@PostMapping("updatePassword")
	public String updatePassword(String currentPwd,
	                             String newPwd,
	                             String checkedPwd,
	                             HttpSession session) {

		User loginUser = (User)(session.getAttribute("loginUser"));

		/*
		 * 기존 코드에서는 이 조건이 반대로 되어 있었음.
		 *
		 * 기존:
		 * if (bCryptPasswordEncoder.matches(currentPwd, loginUser.getPassword()))
		 *
		 * 의미:
		 * 현재 비밀번호가 맞으면 "현재 비밀번호와 일치하지 않습니다." 라고 나옴
		 *
		 * 수정:
		 * 현재 비밀번호가 맞지 않을 때만 오류 처리해야 함
		 */
		if (!bCryptPasswordEncoder.matches(currentPwd, loginUser.getPassword())) {

			session.setAttribute("alertMsg", "현재 비밀번호와 일치하지 않습니다.");

			return "redirect:/admin/mypage";
		}

		// 새 비밀번호와 확인 비밀번호가 다른 경우
		if (!newPwd.equals(checkedPwd)) {

			session.setAttribute("alertMsg", "새 비밀번호와 일치하지 않습니다. 비밀번호 확인을 다시 해주십시오.");

			return "redirect:/admin/mypage";

		}

		// 새 비밀번호 암호화
		String encPwd = bCryptPasswordEncoder.encode(newPwd);

		User u = new User();
		u.setUserNo(loginUser.getUserNo());
		u.setPassword(encPwd);

		int result = adminService.updatePassword(u);

		if (result > 0) {

			// 세션에 있는 사용자 비밀번호도 새 암호화 비밀번호로 갱신
			loginUser.setPassword(encPwd);

			session.setAttribute("loginUser", loginUser);

			session.setAttribute("alertMsg", "비밀번호가 변경되었습니다.");

		} else {

			session.setAttribute("errorMsg", "비밀번호 변경에 실패하였습니다.");

		}

		return "redirect:/admin/mypage";
	}

	// 점주 목록 조회
	@GetMapping("users")
	public String OwnerList(
			
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

		int totalCount = adminService.getOwnerCount(status, keyword); 

		com.kh.burgerstack.common.pagination.PageInfo pageInfo = pi.toPageInfo(totalCount);

		List<User> ownerList = adminService.OwnerList(status, keyword, pi);
		
		// 5. 화면(JSP)으로 데이터 수송
		model.addAttribute("keyword", keyword);
		model.addAttribute("status", status);
		model.addAttribute("ownerList", ownerList);
		model.addAttribute("pageInfo", pageInfo); 

		return "user/OwnerList";
	}
	
	@GetMapping("users/{userId}")
	public String OwnerListDetail(@PathVariable String userId, Model model) {

		System.out.println("받은 userId = " + userId);
		
		User user = adminService.OwnerListDetail(userId);
		
		System.out.println("조회 결과 = " + user);

		/*
		 * 상세 페이지에서 사용할 사용자 정보
		 */
		model.addAttribute("user", user);

		/*
		 * 상세 JSP에서 URL 만들 때 사용할 수 있도록 userId도 같이 넘겨줌
		 */
		model.addAttribute("userId", userId);
		
		return "user/OwnerListDetail";
	}

	// 점주 수정 페이지
	@GetMapping("users/{userId}/edit")
	public String OwnerListEdit(@PathVariable String userId,
	                            Model model) {

	    User user = adminService.OwnerListDetail(userId);

	    /*
	     * 수정 화면에 기존 사용자 정보를 출력하기 위해 사용
	     */
	    model.addAttribute("user", user);

	    /*
	     * 수정 form action URL 만들 때 사용할 수 있도록 userId도 같이 넘겨줌
	     */
	    model.addAttribute("userId", userId);

	    return "user/OwnerListEdit";
	}

	// 점주 수정 기능
	@PostMapping("users/{userId}")
	public String OwnerUpdate(@PathVariable String userId,
	                          User user,
	                          HttpSession session) {
		
		/*
		 * URL에서 받은 userId를 User 객체에 세팅
		 *
		 * /admin/users/owner01
		 */
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

		return "common/errorPage";
	}
}

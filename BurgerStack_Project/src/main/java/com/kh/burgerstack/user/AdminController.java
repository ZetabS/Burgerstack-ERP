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
			
	    System.out.println("===== 등록 요청 =====");
	    System.out.println(u);
		
	    // 비밀번호 암호화
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
	
	// 관리자 마이페이지 정보 수정
	@PostMapping("mypage")
	public ModelAndView update(User u, ModelAndView mv, HttpSession session) {
		
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
	        /*
	         * JSP에서 상태 필터 select name을 status로 보냄
	         *
	         * <select name="status">
	         *
	         * 따라서 Controller도 status로 받아야 함
	         */
	        @RequestParam(value = "status", required = false, defaultValue = "") String status,

	        /*
	         * 검색어
	         *
	         * <common:SearchBar name="keyword" ... />
	         *
	         * 따라서 keyword로 받음
	         */
	        @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,

	        Model model) {

	    System.out.println("status = " + status);
	    System.out.println("keyword = " + keyword);

	    /*
	     * status 값 예시:
	     * ""          전체상태
	     * "ACTIVE"    영업중
	     * "INACTIVE"  폐점
	     *
	     * keyword 값 예시:
	     * 점주 아이디 또는 점주명 검색어
	     */
	    List<User> ownerList =
	            adminService.OwnerList(status, keyword);

	    System.out.println("조회건수 = " + ownerList.size());

	    /*
	     * JSP에서 반복문으로 사용하는 목록
	     *
	     * <c:forEach var="u" items="${ownerList}">
	     */
	    model.addAttribute("ownerList", ownerList);

	    /*
	     * JSP 검색창 값 유지용
	     *
	     * <common:SearchBar name="keyword" value="${keyword}" ... />
	     */
	    model.addAttribute("keyword", keyword);

	    /*
	     * JSP 상태 필터 선택 유지용
	     *
	     * ${param.status}를 쓰고 있긴 하지만,
	     * model에도 담아두면 나중에 ${status}로도 쓸 수 있음
	     */
	    model.addAttribute("status", status);

	    return "user/OwnerList";
	}
	
	// 점주 상세 조회
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
		
		/*
		 * 비밀번호를 새로 입력한 경우에만 암호화해서 수정
		 * 비밀번호 입력이 비어 있으면 null로 보내서 기존 비밀번호 유지 처리
		 */
		if(user.getPassword() != null &&
				!user.getPassword().trim().isEmpty()){
				
			user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
			
		} else {
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
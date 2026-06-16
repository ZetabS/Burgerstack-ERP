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
	public Map<String, Object> login(String userId, String password, HttpSession session) {
	    
	    // 1. 점주 정보 + 점포 상태를 한 번에 가져오는 서비스 호출
	    LoginUser loginUser = loginService.login(userId);
	    
	    // 2. 기본 인증 실패 (아이디 없음 또는 비밀번호 틀림)
	    if((loginUser == null) || (!bCryptPasswordEncoder.matches(password, loginUser.getPassword()))) {
	        return Map.of("success", false, "message", "아이디 또는 비밀번호가 일치하지 않습니다.");
	    }
	    
	    // 3. 점주 계정 로그인 제약 조건 체크 (관리자는 제외)
	    if(!"ADMIN".equals(loginUser.getRole())) {
	        boolean isStoreOpen = "영업중".equals(loginUser.getStoreStatus()); // DB 값 확인 필요
	        boolean isAccountActive = "ACTIVE".equals(loginUser.getStatus());
	        
	        if (!isStoreOpen || !isAccountActive) {
	            return Map.of("success", false, "message", "로그인 불가: 점포가 폐점되었거나 계정이 비활성화 상태입니다.");
	        }
	    }
	    
	    // 4. 성공 시 세션 저장 및 리다이렉트
	    session.setAttribute("loginUser", loginUser);
	    
	    if("ADMIN".equals(loginUser.getRole())) {
	        return Map.of("success", true, "redirectUrl", "/burgerstack/admin/dashboard");
	    }
	    
	    return Map.of("success", true, "redirectUrl", "/burgerstack/owner/dashboard");
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


package com.kh.burgerstack.common.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * 점주 권한 검사 인터셉터
 *
 * 적용 예시)
 * /owner/**
 *
 * - OWNER 권한만 접근 가능
 * - ADMIN 권한은 리다이렉트
 */
@Component
public class OwnerRoleInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        switch (loginUser.getRole()) {
            case "ADMIN": // 관리자는 리다이렉트
                session.setAttribute("alertMsg", "비정상적인 접속입니다.");
                response.sendRedirect("/burgerstack/admin/dashboard");
                return false;
            case "OWNER": // 점주는 통과
                return true;
            default:
                // 역할이 없을 수는 없음.
                throw new RuntimeException("사용자의 역할이 존재하지 않습니다.");
        }
    }
}

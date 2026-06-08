package com.kh.burgerstack.common.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * 비회원 권한 검사 인터셉터
 *
 * 적용 예시)
 * /auth/login
 *
 * - 로그인한 사용자는 각 권한의 대시보드로 리다이렉트
 */
@Component
public class AnonymousOnlyInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        // 로그인한 사용자는 대시보드 페이지로 리다이렉트
        if (loginUser != null) {
            switch (loginUser.getRole()) {
                case "ADMIN":
                    response.sendRedirect("/burgerstack/admin/dashboard");
                    break;
                case "OWNER":
                    response.sendRedirect("/burgerstack/owner/dashboard");
                    break;
                default:
                    // 역할이 없을 수는 없음.
                    throw new RuntimeException("사용자의 역할이 존재하지 않습니다.");
            }
        }

        // 로그인하지 않았다면 통과
        return true;
    }
}

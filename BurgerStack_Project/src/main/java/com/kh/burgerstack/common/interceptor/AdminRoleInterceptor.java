package com.kh.burgerstack.common.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.burgerstack.exception.ForbiddenException;
import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * 관리자 권한 검사 인터셉터
 *
 * 적용 예시)
 * /admin/**
 *
 * - ADMIN 권한만 접근 가능
 * - OWNER 권한은 리다이렉트
 */
@Component
public class AdminRoleInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        switch (loginUser.getRole()) {
            case "ADMIN": // 관리자는 통과
                return true;
            case "OWNER": // 점주는 예외 발생
                throw new ForbiddenException("접근 권한이 없습니다.\n올바른 경로로 접근했는지 확인하세요.");
            default:
                // 역할이 없을 수는 없음.
                throw new RuntimeException("사용자의 역할이 존재하지 않습니다.");
        }
    }
}

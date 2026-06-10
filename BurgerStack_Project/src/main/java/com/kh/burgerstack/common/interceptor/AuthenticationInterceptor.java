package com.kh.burgerstack.common.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*
 * 사용자 인증 검사 인터셉터
 *
 * 적용 예시)
 * /admin/**, /owner/**
 *
 * - 사용자가 로그인하지 않았다면 로그인 페이지로 리다이렉트
 */
@Component
public class AuthenticationInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        // 로그인하지 않은 사용자는 로그인 페이지로 리다이렉트
        if (loginUser == null) {
            response.sendRedirect("/burgerstack/auth/login");
            return false;
        }

        // 아니면 다음 인터셉터로
        return HandlerInterceptor.super.preHandle(request, response, handler);
    }
}

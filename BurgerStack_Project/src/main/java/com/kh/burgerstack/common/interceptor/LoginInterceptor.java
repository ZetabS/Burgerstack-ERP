package com.kh.burgerstack.common.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.burgerstack.user.LoginUser;
import com.kh.burgerstack.user.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*
 * * Interceptor (인터셉터)
 * 로그인 여부를 검사하는 인터셉터
 *
 * 적용 예시)
 * /owner/**
 *
 * => 로그인한 사용자만 접근 가능
 */
@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        // 1. Session 객체 얻기
        HttpSession session = request.getSession();

        // 2. 로그인 사용자 정보 꺼내기
        LoginUser loginUser = (session != null)
                ? (LoginUser) session.getAttribute("loginUser")
                : null;

        // 디버깅 코드
        // System.out.println("session id = " + session.getId());
        // System.out.println("loginUser = " + session.getAttribute("loginUser"));
        // System.out.println("URL = " + request.getRequestURI());

        // 3. 로그인 여부 확인
        if(loginUser != null) {

            // 로그인 상태
            // Controller로 요청 전달
            return true;

        } else {

            // 비로그인 상태

            // 1회성 알림 문구 저장
            session.setAttribute("alertMsg",
                                 "로그인 후 이용 가능한 서비스입니다.");

            // 로그인 페이지로 재요청
            response.sendRedirect("/burgerstack/auth/login");

            // Controller까지 가지 못하도록 차단
            return false;
        }
    }
}
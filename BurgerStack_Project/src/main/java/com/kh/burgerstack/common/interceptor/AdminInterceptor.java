package com.kh.burgerstack.common.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.burgerstack.user.LoginUser;
import com.kh.burgerstack.user.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*
 * 관리자 권한 검사 인터셉터
 *
 * 적용 예시)
 * /admin/**
 *
 * => ADMIN 권한만 접근 가능
 */
@Component
public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        // Session 객체 얻기
        HttpSession session = request.getSession();

        // 로그인 사용자 정보 조회
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        // 1차 : 로그인 여부 확인
        if(loginUser == null) {

            session.setAttribute("alertMsg",
                                 "로그인 후 이용 가능합니다.");

            response.sendRedirect("/burgerstack/auth/login");

            return false;
        }

        // 2차 : 관리자 권한 확인
        // User 객체에 role 컬럼이 있다고 가정
        // role 값 : ADMIN, USER

        if("ADMIN".equals(loginUser.getRole())) {

            // 관리자라면 통과
            return true;

        } else {

            // 일반 회원이라면 접근 차단
            session.setAttribute("alertMsg",
                                 "비정상적인 접속입니다.");

            response.sendRedirect("/burgerstack/owner/dashboard");

            return false;
        }
    }
}
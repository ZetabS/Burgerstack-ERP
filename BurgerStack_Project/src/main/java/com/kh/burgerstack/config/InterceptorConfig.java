package com.kh.burgerstack.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.burgerstack.common.interceptor.AdminInterceptor;
import com.kh.burgerstack.common.interceptor.LoginInterceptor;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {

    @Autowired
    private LoginInterceptor loginInterceptor;

    @Autowired
    private AdminInterceptor adminInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        /*
         * 로그인 사용자만 접근 가능
         */
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/owner/**");

        /*
         * 관리자만 접근 가능
         */
        registry.addInterceptor(adminInterceptor)
                .addPathPatterns(
                        "/admin/**"
                );
    }
}
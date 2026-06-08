package com.kh.burgerstack.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.burgerstack.common.interceptor.AdminRoleInterceptor;
import com.kh.burgerstack.common.interceptor.AnonymousOnlyInterceptor;
import com.kh.burgerstack.common.interceptor.AuthenticationInterceptor;
import com.kh.burgerstack.common.interceptor.OwnerRoleInterceptor;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class InterceptorConfig implements WebMvcConfigurer {
        private final AuthenticationInterceptor authenticationInterceptor;
        private final AdminRoleInterceptor adminRoleInterceptor;
        private final OwnerRoleInterceptor ownerRoleInterceptor;
        private final AnonymousOnlyInterceptor anonymousOnlyInterceptor;

        @Override
        public void addInterceptors(InterceptorRegistry registry) {
                // 로그인한 사용자만 접근 가능
                registry.addInterceptor(authenticationInterceptor)
                                .addPathPatterns("/admin/**", "/owner/**");

                // 관리자만 접근 가능
                registry.addInterceptor(adminRoleInterceptor)
                                .addPathPatterns("/admin/**");

                // 점주만 접근 가능
                registry.addInterceptor(ownerRoleInterceptor)
                                .addPathPatterns("/owner/**");

                // 로그인하지 않은 사용자만 접근 가능
                registry.addInterceptor(anonymousOnlyInterceptor)
                                .addPathPatterns("/auth/login");
        }
}
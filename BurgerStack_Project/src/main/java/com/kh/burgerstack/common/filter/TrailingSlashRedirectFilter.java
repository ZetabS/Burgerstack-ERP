package com.kh.burgerstack.common.filter;

import java.io.IOException;

import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class TrailingSlashRedirectFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain) throws ServletException, IOException {
        String contextPath = request.getContextPath();
        String uri = request.getRequestURI();

        boolean isContextRoot = uri.equals(contextPath + "/")
                || uri.equals("/");

        if (!isContextRoot && uri.endsWith("/")) {
            String queryString = request.getQueryString();
            String redirectUri = uri.substring(0, uri.length() - 1);

            if (queryString != null) {
                redirectUri += "?" + queryString;
            }

            response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
            response.setHeader("Location", redirectUri);
            return;
        }

        filterChain.doFilter(request, response);
    }
}

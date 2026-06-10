package com.kh.burgerstack.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

/**
 * 애플리케이션 전체에서 발생하는 예외를
 * 처리하는 클래스
 */
@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(NotFoundException.class)
    public String handleNotFoundException(NotFoundException e, Model model) {
        model.addAttribute("message", e.getMessage());
        return "error/404";
    }

    @ExceptionHandler(ForbiddenException.class)
    public String handleForbiddenException(ForbiddenException e, Model model) {
        model.addAttribute("message", e.getMessage());
        return "error/403";
    }

    @ExceptionHandler(BadRequestException.class)
    public String handleBadRequestException(BadRequestException e, Model model) {
        model.addAttribute("message", e.getMessage());
        return "error/400";
    }

    @ExceptionHandler(BusinessException.class)
    public String handleBusinessException(BusinessException e, Model model) {
        model.addAttribute("message", e.getMessage());
        return "error/400";
    }

    @ExceptionHandler(AppException.class)
    public String handleAppException(AppException e, Model model) {
        model.addAttribute("message", e.getMessage());
        return "error/400";
    }

    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, Model model) {
        // 실제 서비스에서는 로거를 사용하여 로그를 남기지만 여기서는 sysout으로 로그 처리
        System.out.println(e.getMessage());
        e.printStackTrace();
        model.addAttribute("message", "처리 중 오류가 발생했습니다.");
        return "error/500";
    }
}

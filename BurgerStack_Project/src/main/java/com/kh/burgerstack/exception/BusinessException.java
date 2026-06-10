package com.kh.burgerstack.exception;

public class BusinessException extends AppException {
    private static final String DEFAULT_MESSAGE = "요청을 처리할 수 없습니다.";

    public BusinessException() {
        super(DEFAULT_MESSAGE);
    }

    public BusinessException(String message) {
        super(message);
    }
}
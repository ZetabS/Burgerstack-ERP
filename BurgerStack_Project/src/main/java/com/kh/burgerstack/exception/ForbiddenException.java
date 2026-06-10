package com.kh.burgerstack.exception;

public class ForbiddenException extends AppException {
    private static final String DEFAULT_MESSAGE = "접근 권한이 없습니다.";

    public ForbiddenException() {
        super(DEFAULT_MESSAGE);
    }

    public ForbiddenException(String message) {
        super(message);
    }
}
package com.kh.burgerstack.exception;

public class BadRequestException extends AppException {
    private static final String DEFAULT_MESSAGE = "잘못된 요청입니다.";

    public BadRequestException() {
        super(DEFAULT_MESSAGE);
    }

    public BadRequestException(String message) {
        super(message);
    }
}
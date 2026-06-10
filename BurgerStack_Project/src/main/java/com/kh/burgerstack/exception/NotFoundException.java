package com.kh.burgerstack.exception;

public class NotFoundException extends AppException {
    private static final String DEFAULT_MESSAGE = "요청한 자원을 찾을 수 없습니다.";

    public NotFoundException() {
        super(DEFAULT_MESSAGE);
    }

    public NotFoundException(String message) {
        super(message);
    }
}

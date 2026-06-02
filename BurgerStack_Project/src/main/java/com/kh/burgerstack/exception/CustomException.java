package com.kh.burgerstack.exception;

/**
 * RuntimeException을 상속받아
 * 우리가 직접 만드는 예외 클래스
 */
public class CustomException extends RuntimeException {

    /**
     * 생성자
     * 예외 메시지를 부모(RuntimeException)에게 전달
     * @param message
     */
    public CustomException(String message) {
        super(message);
    }
}


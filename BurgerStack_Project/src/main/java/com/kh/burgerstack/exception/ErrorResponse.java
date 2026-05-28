package com.kh.burgerstack.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 클라이언트(프론트엔드)에게
 * 에러 정보를 전달하기 위한 클래스
 */
@Getter // lombok getter 자동 생성
@AllArgsConstructor // lombok 생성자 자동 생성
public class ErrorResponse {
	
    private int status;			// HTTP 상태 코드
    private String message; 	// 실제 에러 메세지
    
}

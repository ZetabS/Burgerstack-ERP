package com.kh.burgerstack.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 애플리케이션 전체에서 발생하는 예외를
 * 처리하는 클래스
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * CustomException 발생 시 실행되는 메서드
     * @param ex
     * @return
     */
    @ExceptionHandler(CustomException.class)
    public ResponseEntity<ErrorResponse> handleCustomException(CustomException ex) {

        /*
         * 에러 응답 객체 생성
         * 상태코드 + 메시지 저장
         */
        ErrorResponse response = new ErrorResponse(400, ex.getMessage());

        // HTTP 400(Bad Request) 상태와 함께 반환
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * 모든 Exception 처리
     * 위에서 처리하지 못한 예외가 여기로 들어옴
     * @param ex
     * @return
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleException(Exception ex) {


        // 실제 서비스에서는 로그를 남김
        ex.printStackTrace();

        // 사용자에게 보여줄 에러 응답 생성
        ErrorResponse response = new ErrorResponse( 500, "서버 내부 오류");

        // HTTP 500 반환
        return new ResponseEntity<>( response,HttpStatus.INTERNAL_SERVER_ERROR);
        
        
    }
    
    /*
     * @Valid 검증 실패 시 실행
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidationException(
            MethodArgumentNotValidException ex) {

    	// 첫 번째 에러 메시지 가져오기
        String message = ex.getBindingResult()
			               .getFieldError()
		                   .getDefaultMessage();

        // 에러 응답 객체 생성
        ErrorResponse response = new ErrorResponse( 400, message);

        // HTTP 400 반환
        return new ResponseEntity<>( response, HttpStatus.BAD_REQUEST);
    }
}

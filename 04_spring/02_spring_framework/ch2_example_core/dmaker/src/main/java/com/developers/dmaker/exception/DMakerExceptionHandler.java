// 패키지 선언부이다. 'com.developers.dmaker.exception' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.exception;

import com.developers.dmaker.dto.DMakerErrorResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletRequest;

import static com.developers.dmaker.code.DMakerErrorCode.INTERNAL_SERVER_ERROR;
import static com.developers.dmaker.code.DMakerErrorCode.INVALID_REQUEST;

/**
 * DMakerExceptionHandler 클래스는 DMaker 애플리케이션에서 발생하는 예외를 처리하기 위한 전역 예외 처리기이다.
 */
@Slf4j
@ControllerAdvice
public class DMakerExceptionHandler {

    // DMakerException 예외를 처리하는 메서드이다.
    @ExceptionHandler(DMakerException.class)
    @ResponseBody
    public DMakerErrorResponse handleDMakerException(
            DMakerException e,
            HttpServletRequest request
    ) {
        // 예외 발생 시 에러 로그를 기록한다.
        log.error("errorCode: {}, url: {}, message: {}", e.getDMakerErrorCode(),
                request.getRequestURI(), e.getDetailMessage(), e);
        // DMakerErrorResponse 객체를 생성하여 반환한다.
        return DMakerErrorResponse.builder()
                .errorCode(e.getDMakerErrorCode())
                .errorMessage(e.getDetailMessage())
                .build();
    }

    // HttpRequestMethodNotSupportedException 및 MethodArgumentNotValidException 예외를 처리하는 메서드이다.
    @ExceptionHandler(value = {
            HttpRequestMethodNotSupportedException.class,
            MethodArgumentNotValidException.class
    })
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ResponseBody
    public DMakerErrorResponse handleBadRequest(
            Exception e,
            HttpServletRequest request
    ) {
        // 예외 발생 시 에러 로그를 기록한다.
        log.error("url: {}, message: {}", request.getRequestURI(), e.getMessage(), e);
        // DMakerErrorResponse 객체를 생성하여 반환한다.
        return DMakerErrorResponse.builder()
                .errorCode(INVALID_REQUEST)
                .errorMessage(INVALID_REQUEST.getMessage())
                .build();
    }

    // 기타 모든 예외를 처리하는 메서드이다.
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public DMakerErrorResponse handleException(
            Exception e,
            HttpServletRequest request
    ) {
        // 예외 발생 시 에러 로그를 기록한다.
        log.error("url: {}, message: {}", request.getRequestURI(), e.getMessage(), e);
        // DMakerErrorResponse 객체를 생성하여 반환한다.
        return DMakerErrorResponse.builder()
                .errorCode(INTERNAL_SERVER_ERROR)
                .errorMessage(INTERNAL_SERVER_ERROR.getMessage())
                .build();
    }
}

/*

DMakerExceptionHandler
- DMaker 애플리케이션에서 발생하는 다양한 예외를 처리하기 위한 전역 예외 처리기

@ControllerAdvice
- 애너테이션을 사용하여 전역 예외 처리를 활성화

@Slf4j 애너테이션
- Lombok의 @Slf4j 애너테이션을 사용하여 로깅 기능을 제공
- 이를 통해 로깅을 위한 log 객체를 자동으로 생성

@ExceptionHandler 애너테이션
- 특정 예외 타입을 처리하기 위한 메서드를 정의
- 이 애너테이션을 사용하여 다양한 예외 상황을 처리하는 메서드를 선언할 수 있음

handleDMakerException
- DMakerException을 처리하는 메서드
- 예외 발생 시 에러 로그를 기록하고, DMakerErrorResponse 객체를 생성하여 반환

@ResponseBody
- 애너테이션을 사용하여 반환되는 객체를 JSON 형식으로 응답

handleBadRequest 메서드
- HttpRequestMethodNotSupportedException 및 MethodArgumentNotValidException 예외를 처리하는 메서드
- 잘못된 요청에 대해 HTTP 상태 코드 400(BAD_REQUEST)을 설정하고, 에러 로그를 기록
- DMakerErrorResponse 객체를 생성하여 반환

handleException 메서드
- 기타 모든 예외를 처리하는 메서드
- 예외 발생 시 에러 로그를 기록하고, DMakerErrorResponse 객체를 생성하여 반환
- 이 메서드는 일반적인 예외를 처리
- INTERNAL_SERVER_ERROR 코드와 메시지를 반환
*/
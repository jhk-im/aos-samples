// 패키지 선언부이다. 'com.developers.dmaker.exception' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.exception;

import com.developers.dmaker.code.DMakerErrorCode;
import lombok.Getter;

/**
 * DMakerException 클래스는 DMaker 애플리케이션에서 발생하는 예외를 처리하기 위한 커스텀 예외 클래스이다.
 */
@Getter
// DMakerErrorCode와 상세 메시지를 포함하는 커스텀 예외 클래스이다.
public class DMakerException extends RuntimeException {

    // 예외의 원인 또는 종류를 나타내는 코드이다. DMakerErrorCode 타입이다.
    private DMakerErrorCode dMakerErrorCode;

    // 예외의 상세 메시지이다. 추가적인 예외 정보를 제공한다.
    private String detailMessage;

    // DMakerErrorCode를 인수로 받아 예외를 생성하는 생성자이다.
    public DMakerException(DMakerErrorCode dMakerErrorCode) {
        // 부모 클래스인 RuntimeException의 생성자를 호출하여 예외 메시지를 설정한다.
        super(dMakerErrorCode.getMessage());
        // 전달된 DMakerErrorCode를 멤버 변수에 저장한다.
        this.dMakerErrorCode = dMakerErrorCode;
        // 예외의 상세 메시지로 DMakerErrorCode의 메시지를 설정한다.
        this.detailMessage = dMakerErrorCode.getMessage();
    }

    // DMakerErrorCode와 상세 메시지를 인수로 받아 예외를 생성하는 생성자이다.
    public DMakerException(DMakerErrorCode dMakerErrorCode, String detailMessage) {
        // 부모 클래스인 RuntimeException의 생성자를 호출하여 예외 메시지를 설정한다.
        super(detailMessage);
        // 전달된 DMakerErrorCode를 멤버 변수에 저장한다.
        this.dMakerErrorCode = dMakerErrorCode;
        // 예외의 상세 메시지로 전달된 detailMessage를 설정한다.
        this.detailMessage = detailMessage;
    }
}

/*
DMakerException
- DMaker 애플리케이션에서 발생하는 예외를 처리하기 위한 커스텀 예외 클래스이다.
- 이 클래스는 RuntimeException을 상속받아 런타임 예외로 처리된다.

@Getter 애너테이션:
- Lombok의 @Getter 애너테이션을 사용하여 클래스의 모든 필드에 대해 getter 메서드를 자동으로 생성한다.

DMakerErrorCode dMakerErrorCode
- 예외의 원인 또는 종류를 나타내는 코드이다.
- DMakerErrorCode는 애플리케이션에서 정의한 에러 코드 열거형이다.

String detailMessage
- 예외의 상세 메시지로, 예외 발생 원인에 대한 추가적인 정보를 제공한다.

첫 번째 생성자
- DMakerErrorCode를 인수로 받아 예외를 생성하며 DMakerErrorCode의 메시지를 예외의 기본 메시지와 상세 메시지로 설정한다.
두 번째 생성자
- DMakerErrorCode와 detailMessage를 인수로 받아 예외를 생성하며 전달된 detailMessage를 예외의 기본 메시지와 상세 메시지로 설정한다.
*/

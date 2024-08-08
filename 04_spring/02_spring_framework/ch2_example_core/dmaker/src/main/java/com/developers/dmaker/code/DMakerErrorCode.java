// 패키지 선언부이다. 'com.developers.dmaker.code' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.code;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * DMakerErrorCode 클래스는 DMaker 애플리케이션에서 발생할 수 있는 다양한 오류 코드를 정의하는 열거형(enum)이다.
 * @Getter: Lombok의 애너테이션으로, 각 열거형 상수의 message 필드에 대한 getter 메서드를 자동으로 생성한다.
 * @AllArgsConstructor: Lombok의 애너테이션으로, 모든 필드를 초기화하는 생성자를 자동으로 생성한다. 여기서는 message 필드를 초기화한다.
 */
@Getter
@AllArgsConstructor
public enum DMakerErrorCode {
    // 개발자를 찾을 수 없을 때 사용되는 오류 코드이다. "해당되는 개발자가 없습니다." 메시지를 포함한다.
    NO_DEVELOPER("해당되는 개발자가 없습니다."),

    // 중복된 멤버 ID가 존재할 때 사용되는 오류 코드이다. "memberId가 중복됩니다." 메시지를 포함한다.
    DUPLICATED_MEMBER_ID("memberId가 중복됩니다."),

    // 개발자의 레벨과 경력 연수가 맞지 않을 때 사용되는 오류 코드이다. "개발자 레벨과 연차가 맞지 않습니다." 메시지를 포함한다.
    LEVEL_AND_EXPERIENCE_YEARS_NOT_MATCH("개발자 레벨과 연차가 맞지 않습니다."),

    // 서버에서 내부 오류가 발생했을 때 사용되는 오류 코드이다. "서버에 오류가 발생했습니다." 메시지를 포함한다.
    INTERNAL_SERVER_ERROR("서버에 오류가 발생했습니다."),

    // 잘못된 요청을 했을 때 사용되는 오류 코드이다. "잘못된 요청입니다." 메시지를 포함한다.
    INVALID_REQUEST("잘못된 요청입니다.");

    // 오류 메시지를 저장하는 필드이다.
    private final String message;
}

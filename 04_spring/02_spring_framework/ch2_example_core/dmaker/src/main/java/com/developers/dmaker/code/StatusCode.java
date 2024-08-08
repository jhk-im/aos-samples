// 패키지 선언부이다. 'com.developers.dmaker.code' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.code;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * StatusCode 클래스는 개발자의 고용 상태를 나타내는 열거형(enum)이다.
 * @AllArgsConstructor: Lombok의 애너테이션으로, 모든 필드를 초기화하는 생성자를 자동으로 생성한다. 여기서는 description 필드를 초기화한다.
 * @Getter: Lombok의 애너테이션으로, 각 열거형 상수의 description 필드에 대한 getter 메서드를 자동으로 생성한다.
 */
@AllArgsConstructor
@Getter
public enum StatusCode {
    // 'EMPLOYED' 상태이다. "고용"이라는 설명을 가진다.
    EMPLOYED("고용"),

    // 'RETIRED' 상태이다. "퇴직"이라는 설명을 가진다.
    RETIRED("퇴직");

    // 각 상태의 설명을 저장하는 필드이다.
    private final String description;
}

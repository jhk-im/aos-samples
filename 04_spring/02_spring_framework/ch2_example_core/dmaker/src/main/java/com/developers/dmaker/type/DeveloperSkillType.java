// 패키지 선언부이다. 'com.developers.dmaker.type' 패키지에 속한 클래스임을 나타낸다.
// 패키지는 자바 클래스들을 그룹화하는 기본 단위로, 클래스의 경로와 네임스페이스를 정의한다.
package com.developers.dmaker.type;

// 외부 라이브러리인 Lombok을 import 하는 부분이다.
// '@AllArgsConstructor' 애너테이션은 모든 필드에 대한 생성자를 자동으로 생성한다.
// '@Getter' 애너테이션은 모든 필드에 대한 getter 메서드를 자동으로 생성한다.
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 이 클래스는 개발자의 기술 유형을 나타내는 enum이다.
 * 각 enum 상수는 한국어로 된 설명을 포함하고 있다.
 */
@AllArgsConstructor
@Getter
public enum DeveloperSkillType {
    // 'BACK_END' 상수이다. "백엔드 개발자"라는 설명을 가진다.
    BACK_END("백엔드 개발자"),
    // 'FRONT_END' 상수이다. "프론트엔드 개발자"라는 설명을 가진다.
    FRONT_END("프론트엔드 개발자"),
    // 'FULL_STACK' 상수이다. "풀스택 개발자"라는 설명을 가진다.
    FULL_STACK("풀스택 개발자");

    // 각 enum 상수에 대한 설명을 저장하는 필드이다.
    // 이 필드는 final로 선언되어 있으며, 생성자를 통해 초기화된다.
    private final String description;
}

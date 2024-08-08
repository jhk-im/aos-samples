// 패키지 선언부이다. 'com.developers.dmaker.dto' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.dto;

import com.developers.dmaker.type.DeveloperLevel;
import com.developers.dmaker.type.DeveloperSkillType;
import lombok.*;

/**
 * EditDeveloper 클래스는 개발자 수정 요청을 처리하는 DTO(Data Transfer Object) 클래스이다.
 * @Getter, @Setter: 각 필드에 대한 getter와 setter 메서드를 자동으로 생성한다.
 * @AllArgsConstructor: 모든 필드를 초기화하는 생성자를 자동으로 생성한다.
 * @NoArgsConstructor: 파라미터가 없는 기본 생성자를 자동으로 생성한다.
 * @Builder: 빌더 패턴을 구현하여 객체 생성 시 유연성을 제공한다.
 */
public class EditDeveloper {

    // 개발자 수정 요청 데이터를 담는 내부 정적 클래스이다.
    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    @Builder
    public static class Request {

        // 개발자 레벨을 나타내는 필드이다.
        private DeveloperLevel developerLevel;

        // 개발자 기술 유형을 나타내는 필드이다.
        private DeveloperSkillType developerSkillType;

        // 개발자의 경력 연수를 나타내는 필드이다.
        private Integer experienceYears;

        // 개발자의 이름을 나타내는 필드이다.
        private String name;

        // 개발자의 나이를 나타내는 필드이다.
        private Integer age;
    }
}

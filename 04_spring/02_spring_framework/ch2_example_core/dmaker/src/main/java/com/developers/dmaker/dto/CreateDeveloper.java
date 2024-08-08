// 패키지 선언부이다. 'com.developers.dmaker.dto' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.dto;

import com.developers.dmaker.entity.Developer;
import com.developers.dmaker.type.DeveloperLevel;
import com.developers.dmaker.type.DeveloperSkillType;
import lombok.*;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * CreateDeveloper 클래스는 개발자 생성 요청 및 응답을 처리하는 DTO(Data Transfer Object) 클래스이다.
 * @Getter, @Setter: 각 필드에 대한 getter와 setter 메서드를 자동으로 생성한다.
 * @AllArgsConstructor: 모든 필드를 초기화하는 생성자를 자동으로 생성한다.
 * @NoArgsConstructor: 파라미터가 없는 기본 생성자를 자동으로 생성한다.
 * @Builder: 빌더 패턴을 구현하여 객체 생성 시 유연성을 제공한다.
 */
public class CreateDeveloper {

    // 개발자 생성 요청 데이터를 담는 내부 정적 클래스이다.
    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    @Builder
    public static class Request {

        // 개발자 레벨을 나타내는 필드이다. null일 수 없다.
        @NotNull
        private DeveloperLevel developerLevel;

        // 개발자 기술 유형을 나타내는 필드이다. null일 수 없다.
        @NotNull
        private DeveloperSkillType developerSkillType;

        // 개발자의 경력 연수를 나타내는 필드이다. null일 수 없으며, 최소 값은 0이다.
        @NotNull
        @Min(0)
        private Integer experienceYears;

        // 개발자의 멤버 ID를 나타내는 필드이다. null일 수 없으며, 최소 길이는 3자, 최대 길이는 50자이다.
        @NotNull
        @Size(min = 3, max = 50, message = "invalid memberId")
        private String memberId;

        // 개발자의 이름을 나타내는 필드이다. null일 수 없으며, 최소 길이는 2자, 최대 길이는 50자이다.
        @NotNull
        @Size(min = 2, max = 50, message = "invalid name")
        private String name;

        // 개발자의 나이를 나타내는 필드이다. null일 수 없으며, 최소 값은 18이다.
        @NotNull
        @Min(18)
        private Integer age;
    }

    // 개발자 생성 응답 데이터를 담는 내부 정적 클래스이다.
    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    @Builder
    public static class Response {

        // 개발자 레벨을 나타내는 필드이다.
        private DeveloperLevel developerLevel;

        // 개발자 기술 유형을 나타내는 필드이다.
        private DeveloperSkillType developerSkillType;

        // 개발자의 경력 연수를 나타내는 필드이다.
        private Integer experienceYears;

        // 개발자의 멤버 ID를 나타내는 필드이다.
        private String memberId;

        // 개발자의 이름을 나타내는 필드이다.
        private String name;

        // 개발자의 나이를 나타내는 필드이다.
        private Integer age;

        // Developer 엔티티 객체를 Response 객체로 변환하는 메서드이다.
        public static Response fromEntity(Developer developer) {
            // Developer 엔티티의 각 필드를 Response 객체의 필드에 매핑하여 반환한다.
            return Response.builder()
                    .developerLevel(developer.getDeveloperLevel())
                    .developerSkillType(developer.getDeveloperSkillType())
                    .experienceYears(developer.getExperienceYears())
                    .memberId(developer.getMemberId())
                    .name(developer.getName())
                    .age(developer.getAge())
                    .build();
        }
    }
}

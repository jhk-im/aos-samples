// 패키지 선언부이다. 'com.developers.dmaker.entity' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.entity;

import com.developers.dmaker.code.StatusCode;
import com.developers.dmaker.type.DeveloperLevel;
import com.developers.dmaker.type.DeveloperSkillType;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

/**
 * Developer 클래스는 개발자 정보를 저장하는 엔티티이다.
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Entity
@EntityListeners(AuditingEntityListener.class)
@Table(name = "developer")
public class Developer {

    // 'id' 필드이다. 기본 키이며, 자동 증가한다.
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long id;

    // 'developerLevel' 필드이다. 개발자의 레벨을 저장한다.
    @Enumerated(EnumType.STRING)
    private DeveloperLevel developerLevel;

    // 'developerSkillType' 필드이다. 개발자의 기술 유형을 저장한다.
    @Enumerated(EnumType.STRING)
    private DeveloperSkillType developerSkillType;

    // 'status' 필드이다. 개발자의 상태를 저장한다.
    @Enumerated(EnumType.STRING)
    private StatusCode status;

    // 'experienceYears' 필드이다. 개발자의 경력 년수를 저장한다.
    private Integer experienceYears;

    // 'memberId' 필드이다. 멤버 ID를 저장한다.
    private String memberId;

    // 'name' 필드이다. 개발자의 이름을 저장한다.
    private String name;

    // 'age' 필드이다. 개발자의 나이를 저장한다.
    private Integer age;

    // 'createdAt' 필드이다. 레코드 생성 시간을 저장한다.
    @CreatedDate
    private LocalDateTime createdAt;

    // 'updatedAt' 필드이다. 레코드 마지막 수정 시간을 저장한다.
    @LastModifiedDate
    private LocalDateTime updatedAt;
}

/*
Lombok 애너테이션을 사용하여 getter, setter, builder, 기본 생성자 및 모든 필드를 초기화하는 생성자를 자동으로 생성한다.
@Entity 애너테이션을 사용하여 이 클래스가 JPA 엔티티임을 나타내고,
@Table 애너테이션을 사용하여 데이터베이스 테이블 이름을 지정한다.
@EntityListeners 애너테이션을 사용하여 AuditingEntityListener를 등록함으로써 JPA 감사 기능을 활성화한다.
*/
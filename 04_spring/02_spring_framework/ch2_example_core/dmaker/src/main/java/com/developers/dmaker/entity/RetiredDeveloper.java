// 패키지 선언부이다. 'com.developers.dmaker.entity' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

/**
 * RetiredDeveloper 클래스는 은퇴한 개발자 정보를 저장하는 엔티티이다.
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Entity
@EntityListeners(AuditingEntityListener.class)
@Table(name = "retired_developer")
public class RetiredDeveloper {

    // 'id' 필드이다. 기본 키이며, 자동 증가한다.
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long id;

    // 'memberId' 필드이다. 은퇴한 개발자의 멤버 ID를 저장한다.
    private String memberId;

    // 'name' 필드이다. 은퇴한 개발자의 이름을 저장한다.
    private String name;

    // 'createdAt' 필드이다. 레코드 생성 시간을 저장한다.
    @CreatedDate
    private LocalDateTime createdAt;

    // 'updatedAt' 필드이다. 레코드 마지막 수정 시간을 저장한다.
    @LastModifiedDate
    private LocalDateTime updatedAt;
}

/*

@Getter, @Setter, @Builder, @NoArgsConstructor, @AllArgsConstructor
- Lombok 라이브러리를 사용하여 자동으로 getter, setter, builder 메서드 및 생성자를 생성한다.
@Entity
- JPA 엔티티임을 나타내며, 해당 클래스가 데이터베이스 테이블과 매핑됨을 의미한다.
@EntityListeners(AuditingEntityListener.class)
- 이 엔티티에 대해 JPA 감사(Auditing) 기능을 활성화한다.
@Table(name = "retired_developer")
- 이 엔티티가 retired_developer 테이블과 매핑됨을 나타낸다.

JPA 감사 기능
@CreatedDate
- 엔티티가 처음 생성될 때 현재 시간이 자동으로 설정되는 필드이다.
@LastModifiedDate
- 엔티티가 마지막으로 수정될 때 현재 시간이 자동으로 설정되는 필드이다.
AuditingEntityListener
- 엔티티의 생명주기 이벤트를 감지하여 @CreatedDate와 @LastModifiedDate 필드를 자동으로 설정하는 리스너이다.
*/
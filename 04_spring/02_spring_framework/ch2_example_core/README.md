# 예제 - 개발자 키우기

## 개발자 키우기 주요 기능

### 개발자 생성하기

- POST 메서드를 활용하여 개발자를 생성
- validation

### 개발자 목록과 특정 개발자 상세 내용 확인

- GET 메서드를 활용하여 개발자(들)의 정보를 확인
- DTO(Data Transfer Object)의 개념과 역할

### 개발자 정보 수정

- PUT 메서드를 활용하여 개발자의 정보를 수정

### 개발자 삭제

- DELETE 메서드를 활용하여 개발자의 정보를 삭제(분리보관)
- 트랜잭션

## HTTP (Hyper Text Transfer Protocol)

HTTP는 인터넷에서 데이터를 주고받기 위한 프로토콜로, 클라이언트와 서버 간에 통신을 가능하게 한다. "Hyper Text"란 단순한 텍스트 이상의 데이터(이미지, 비디오, 텍스트 등을 포함한 하이퍼링크 문서)를 의미한다.

### HTTP 요청(Request) 메시지

- HTTP 요청 메시지는 크게 세 부분으로 구성
  - 요청 라인(Request Line): HTTP 메서드 (GET, POST, PUT, DELETE 등), 요청하는 리소스의 URI, 그리고 HTTP 버전 정보를 포함
  - 헤더(Headers): 요청에 대한 추가 정보(메타데이터)를 제공하며, 여러 키-값 쌍으로 구성(Content-Type, Accept, User-Agent 등)
  - 바디(Body): (옵션) 데이터를 전송할 때 사용되며, 주로 POST 및 PUT 요청에서 사용됨

```text
POST /create-developer HTTP/1.1
Content-Type: application/json
Accept: application/json

{
  "developerLevel": "JUNIOR",
  "developerSkillType": "FULL_STACK",
  "experienceYears": 2,
  "memberId": "sunny.flower",
  "name": "sun",
  "age": 36
}
```

### HTTP 응답(Response) 메시지

- HTTP 응답 메시지 역시 세 부분으로 구성
  - 상태 라인(Status Line): HTTP 버전, 상태 코드(예: 200 OK, 404 Not Found), 그리고 응답 상태를 설명하는 상태 메시지를 포함
  - 헤더(Headers): 응답에 대한 추가 정보를 제공
  - 바디(Body): 서버가 클라이언트에 보내는 데이터를 포함하며, 종종 JSON, HTML 등의 형식으로 제공

```text
HTTP/1.1 200 OK
Content-Type: application/json
Transfer-Encoding: chunked
Date: Sat, 17 Jul 2021 15:33:34 GMT
Keep-Alive: timeout=60
Connection: keep-alive

{
  "developerLevel": "JUNIOR",
  "developerSkillType": "FULL_STACK",
  "experienceYears": 2,
  "memberId": "sunny.flower",
  "name": "sun",
  "age": 36
}
```

## 트랜잭션

트랜잭션의 정의: 트랜잭션은 데이터베이스 작업의 일관성과 무결성을 보장하기 위해 사용된다. 트랜잭션이 성공적으로 완료되면 데이터베이스에 영구적으로 반영되지만, 중간에 오류가 발생하면 모든 작업이 롤백되어 데이터베이스가 이전 상태로 복구된다. 이는 데이터 무결성을 유지하는 데 중요한 역할을 한다.

### @Transactional 애너테이션 적용

서비스 클래스의 메서드에 @Transactional 애너테이션을 적용함으로써 해당 메서드에서 실행되는 모든 데이터베이스 작업이 트랜잭션으로 관리되도록 한다.

- 이 애너테이션이 적용된 메서드는 다음과 같은 특징을 가짐
  - 원자성 (Atomicity): 메서드 내의 모든 작업이 하나의 단위로 실행됨 / 모든 작업이 성공적으로 완료되거나, 하나라도 실패하면 전체 작업이 롤백됨
  - 일관성 (Consistency): 트랜잭션이 성공적으로 완료되면 데이터베이스의 상태가 일관성을 유지함
  - 격리성 (Isolation): 트랜잭션 간의 작업이 서로 간섭하지 않도록 격리됨
  - 내구성 (Durability): 트랜잭션이 성공적으로 완료되면 그 결과가 영구적으로 저장됨

## JPA 감사 기능(Auditing)

JPA 감사 기능은 엔티티의 생성 및 수정 시각을 자동으로 기록해주는 기능이다. 이를 통해 애플리케이션에서 데이터의 변경 이력을 쉽게 추적할 수 있디. JPA 감사 기능을 사용하면 별도의 코드 작성 없이 엔티티가 언제 생성되고 수정되었는지에 대한 정보를 자동으로 관리할 수 있다.

### 주요 구성 요소

- 애너테이션
  - @CreatedDate: 엔티티가 생성된 날짜와 시간을 자동으로 기록함
  - @LastModifiedDate: 엔티티가 마지막으로 수정된 날짜와 시간을 자동으로 기록함
  - @CreatedBy: 엔티티가 생성된 사용자 정보를 기록함
  - @LastModifiedBy: 엔티티가 마지막으로 수정된 사용자 정보를 기록함
- 엔티티 리스너
  - AuditingEntityListener: JPA 엔티티의 생명주기 이벤트를 감지하여 감사 정보를 자동으로 설정함
  - 이 리스너를 활성화 하기 위해 엔티티 클래스에 @EntityListeners(AuditingEntityListener.class) 애너테이션을 추가함
- 구성 클래스
  - 스프링 부트 애플리케이션에서 감사 기능을 활성화하려면 @EnableJpaAuditing 애너테이션을 사용함
  - 이 애너테이션을 메인 애플리케이션 클래스 또는 설정 클래스에 추가함

```java
package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class DemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}
```

```java
package com.example.demo.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@EntityListeners(AuditingEntityListener.class)
@Table(name = "developer")
public class Developer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @CreatedDate
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    private LocalDateTime updatedAt;
}
```

### 감사 기능의 동작

- 엔티티 생성 시: 새로운 Developer 엔티티가 데이터베이스에 저장될 때 createdAt 필드가 현재 날짜와 시간으로 자동 설정됨
- 엔티티 수정 시: 기존 Developer 엔티티가 수정될 때 updatedAt 필드가 현재 날짜와 시간으로 자동 설정됨

### 중요한 고려 사항

- @CreatedDate와 @LastModifiedDate 필드는 일반적으로 LocalDateTime, Date, Instant 등의 날짜/시간 타입으로 선언됨
- @Column(updatable = false)와 같은 속성을 사용하여 특정 필드가 생성 시에만 설정되고 이후에는 수정되지 않도록 할 수 있음
- 감사 기능을 사용하려면 Spring Data JPA와 관련된 의존성을 추가해야함

### 감사 기능의 장점

- 자동화: 생성 및 수정 시간 관리가 자동화되어 개발자의 작업을 줄여줌
- 일관성: 데이터베이스에 저장된 엔티티의 생성 및 수정 시각이 일관성 있게 관리됨
- 추적성: 데이터 변경 이력을 추적할 수 있어 데이터 무결성과 감사 가능성을 높임

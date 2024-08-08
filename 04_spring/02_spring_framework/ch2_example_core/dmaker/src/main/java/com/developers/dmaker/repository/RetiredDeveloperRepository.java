// 패키지 선언부이다. 'com.developers.dmaker.repository' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.repository;

import com.developers.dmaker.entity.RetiredDeveloper;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * RetiredDeveloperRepository 인터페이스는 은퇴한 개발자 관련 데이터베이스 작업을 처리하는 JPA 리포지토리이다.
 */
@Repository
// JpaRepository를 상속받아 기본적인 CRUD 메서드를 제공한다.
// RetiredDeveloper 엔티티와 그 기본 키 타입(Long)을 제네릭으로 지정한다.
public interface RetiredDeveloperRepository extends JpaRepository<RetiredDeveloper, Long> {
}

/*
@Repository 애너테이션
- 인터페이스가 스프링의 리포지토리 컴포넌트임을 나타냄
- 데이터 접근 계층의 컴포넌트로서 스프링이 관리함
JpaRepository<RetiredDeveloper, Long>:
- JpaRepository 인터페이스를 상속받아, 기본적인 CRUD (Create, Read, Update, Delete) 작업을 수행할 수 있는 메서드를 자동으로 제공함
- 제네릭 타입으로 RetiredDeveloper 엔티티와 그 기본 키 타입 Long을 지정하여, 해당 엔티티에 대한 데이터베이스 작업을 처리함
인터페이스의 기능
- 기본 CRUD 작업 지원
  - JpaRepository는 기본적인 데이터베이스 작업 메서드들을 제공함
  - 예를 들어, save(), findById(), findAll(), delete()와 같은 메서드를 사용할 수 있음
- 은퇴한 개발자 데이터 관리
  - RetiredDeveloper 엔티티는 은퇴한 개발자 정보를 저장하기 위한 엔티티
  - 리포지토리를 통해 은퇴한 개발자 정보를 저장하고 조회할 수 있음
- 기본 제공 메서드 외 커스텀 메서드
  - 필요에 따라 커스텀 쿼리 메서드를 추가하여 특정 조건에 맞는 데이터를 조회할 수 있음
  - 예를 들어, 특정 조건에 맞는 은퇴한 개발자를 조회하는 메서드를 정의할 수 있음
*/
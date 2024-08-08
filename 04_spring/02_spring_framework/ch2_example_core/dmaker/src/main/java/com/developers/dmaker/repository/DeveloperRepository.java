// 패키지 선언부이다. 'com.developers.dmaker.repository' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.repository;

import com.developers.dmaker.code.StatusCode;
import com.developers.dmaker.entity.Developer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * DeveloperRepository 인터페이스는 개발자 관련 데이터베이스 작업을 처리하는 JPA 리포지토리이다.
 */
@Repository
// JpaRepository를 상속받아 기본적인 CRUD 메서드를 제공한다.
// Developer 엔티티와 그 기본 키 타입(Long)을 제네릭으로 지정한다.
public interface DeveloperRepository extends JpaRepository<Developer, Long> {

    // 멤버 ID로 개발자를 조회하는 메서드이다.
    // 반환 타입은 Optional<Developer>로, 해당 멤버 ID를 가진 개발자가 존재하지 않을 경우 Optional.empty()를 반환한다.
    Optional<Developer> findByMemberId(String memberId);

    // 상태 코드로 개발자 목록을 조회하는 메서드이다.
    // 입력된 StatusCode와 일치하는 상태를 가진 개발자들을 리스트로 반환한다.
    List<Developer> findDevelopersByStatusEquals(StatusCode status);
}

/*
- `@Repository` 애너테이션
  - 이 인터페이스가 스프링의 리포지토리 컴포넌트임을 나타냄
  - 데이터 접근 계층의 컴포넌트로서 스프링이 관리함
- `JpaRepository<Developer, Long>`
  - JpaRepository 인터페이스를 상속받아, 기본적인 CRUD (Create, Read, Update, Delete) 작업을 수행할 수 있는 메서드를 자동으로 제공함
  - 제네릭 타입으로 Developer 엔티티와 그 기본 키 타입 Long을 지정하여, 해당 엔티티에 대한 데이터베이스 작업을 처리함
- `Optional<Developer> findByMemberId(String memberId)`
  - memberId를 기반으로 개발자를 조회하는 메서드
  - 반환 타입이 `Optional<Developer>`이므로, 해당 memberId를 가진 개발자가 존재하지 않을 경우 Optional.empty()를 반환함
  - NullPointerException을 방지하고, 존재 유무를 명시적으로 처리
- `List<Developer> findDevelopersByStatusEquals(StatusCode status)`
  - status 코드에 따라 개발자 목록을 조회하는 메서드
  - 주어진 StatusCode와 일치하는 상태를 가진 개발자들을 리스트 형태로 반환
  - (ex) StatusCode.EMPLOYED를 전달하면 현재 고용된 모든 개발자들을 반환함
*/
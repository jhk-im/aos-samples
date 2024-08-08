// 패키지 선언부이다. 'com.developers.dmaker' 패키지에 속한 클래스임을 나타낸다.
// 패키지는 자바 클래스들을 그룹화하는 기본 단위로, 클래스의 경로와 네임스페이스를 정의한다.
package com.developers.dmaker;

// 외부 라이브러리들을 import 하는 부분이다.
// 'SpringApplication' 클래스는 Spring Boot 애플리케이션을 실행하기 위해 사용된다.
import org.springframework.boot.SpringApplication;
// 'SpringBootApplication' 애너테이션은 Spring Boot의 자동 설정, Bean 읽기와 생성, Spring Boot 설정을 활성화한다.
import org.springframework.boot.autoconfigure.SpringBootApplication;
// 'EnableJpaAuditing' 애너테이션은 JPA 감사(auditing) 기능을 활성화한다. 이는 엔터티의 생성 및 수정 시간을 자동으로 기록하는 데 사용된다.
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

// 이 애너테이션은 JPA 감사(auditing) 기능을 활성화한다. 이를 통해 엔터티의 생성 시간, 수정 시간 등을 자동으로 관리할 수 있다.
@EnableJpaAuditing

// 이 애너테이션은 @Configuration, @EnableAutoConfiguration, @ComponentScan을 포함하는 메타 애너테이션이다.
// 이를 통해 스프링 부트 애플리케이션의 자동 설정을 쉽게 구성할 수 있다.
@SpringBootApplication
// 'DmakerApplication' 클래스 선언부이다. 이 클래스는 애플리케이션의 진입점(entry point)이다.
public class DmakerApplication {
	// main 메서드는 자바 애플리케이션의 시작 지점이다.
    public static void main(String[] args) {
        // SpringApplication.run(...) 메서드를 호출하여 스프링 부트 애플리케이션을 실행한다.
		// SpringApplication.run() 메서드는 전달된 클래스(DmakerApplication)와 인수(args)를 사용하여 스프링 부트 애플리케이션 컨텍스트를 생성하고 애플리케이션을 실행한다.
        SpringApplication.run(DmakerApplication.class, args);
    }

}

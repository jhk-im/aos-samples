# ch1 - Spring Core

## 1. 자바, 그리고 스프링, 스프링 부트

### Java : 객체지향적 프로그래밍 언어

```java
public class JavaProject {
 // Java를 처음 접하면서 보게 되는 코드
 public static void main(String[] args) {
  System.out.println("Hello World");
 }
}
```

- 우리가 배우게 될 스프링의 근간이 되는 언어
- 스프링은 자바 뿐 아니라 코틀린, 그루비로도 사용할 수 있으나 여기서는 자바로 진행
- 스프링 자체도 거의 대부분 자바로 만들어져 있음

### Spring Framework : 기업용 어플리케이션을 만드는데 사용 가능한 오픈소스 프레임워크

- 자바를 이용해서 어플리케이션을 쓰기 위해 활용하는 프레임워크(여러 툴이 있는 템플릿)
- 자바, 서블릿, J2EE >>>>> 스프링 프레임워크
- 스프링 내에는 동일한 역할을 하는 다양한 기능이 있으며, 그 중에서 적합한 툴을 선택할 수 있어야 함

### Spring Boot : 스프링 기반으로 자주 사용되는 설정으로 손쉽게 개발할 수 있게 해주는 상위 프레임워크

- 스프링보다 한층 더 편리한 프레임워크
- 웹 어플리케이션 서버 내장 (예: 톰캣 등)
- 자동 설정, 설정 표준화
- 하지만 원한다면 모두 마음대로 설정할 수 있음

## 2, 스프링의 핵심

스프링 프레임워크는 다양한 핵심 기술을 포함하고 있으며, 이들은 어플리케이션의 효율적인 개발 및 운영을 지원함

- Core (DI, IoC): Dependency Injection과 Inversion of Control을 통해 클래스의 생성과 의존성 관리를 스프링이 자동으로 처리하여 어플리케이션의 유연성을 높이고 결합도를 낮춤
- AOP (Aspect Oriented Programming): 횡단 관심사를 분리하여 공통 기능을 모듈화하고 재사용성을 향상시킴
- Validation, Data Binding: 외부 데이터의 유효성 검사 및 객체로의 바인딩을 쉽게 수행할 수 있게 지원
- Resource: 애플리케이션 설정 파일 등의 리소스에 접근하는 통합된 방법을 제공
- SpEL (Spring Expression Language): 간단한 표현식으로 객체 그래프를 조회하거나 조작하는 기능을 제공
- Null-Safety: 안전한 null 처리 방법을 제공하여 런타임 에러를 방지

### 스프링의 디자인 철학

- 스프링의 디자인 철학은 개발자에게 높은 수준의 자유도와 유연성을 제공하는 것에 중점을 두고 있음
- 자유도는 때때로 스프링을 배우고 사용하는 것을 복잡하게 만들 수 있음
  - 모듈화 및 확장성: 다양한 기능과 외부 모듈을 쉽게 통합
  - 지속적인 개발: 지속적으로 기능을 추가하며 프레임워크를 발전시킴
  - 호환성 유지: 이전 버전과의 호환성을 강조하며, 이로 인해 일부 레거시 코드의 복잡성이 증가할 수 있
  - API 디자인: 섬세한 API 디자인을 통해 고품질의 코드를 유지
  - 코드 품질: 스프링 프로젝트는 고품질의 코드 유지를 위해 GitHub을 활용하여 효과적인 PR과 이슈 관리를 수행

참고 문헌
[스프링 프레임워크 개요](https://docs.spring.io/spring-framework/docs/5.0.0.RC2/spring-framework-reference/overview.html#overview-modules)
[스프링 프레임워크 핵심 기술](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#spring-core)

## 3. IoC(Inversion of Control), DI(Dependency Injection)

- IoC (제어의 역전)와 DI (의존성 주입)는 애플리케이션의 구성 및 관리 방식을 근본적으로 변화시키는 기본적인 개념
- IoC와 DI를 활용함으로써, 스프링은 전통적인 방식에서 벗어나 의존성의 생성과 관리를 프레임워크가 주도하게 함
- 컴포넌트 간의 의존성을 줄이고 모듈성을 향상시키는 데 도움을 줌
  - IoC (제어의 역전): 이 원칙은 애플리케이션이 의존성의 생명 주기와 관리를 제어하는 대신, 프레임워크(이 경우 스프링)가 이 역할을 맡게 됨을 의미하며 이로 인해 컴포넌트 간의 의존성이 감소하고 모듈성이 향상됨
  - DI (의존성 주입): IoC의 특정 형태로, 의존성(서비스, 데이터 등)이 컴포넌트(클래스 등) 내부에서 생성되는 대신, 컴포넌트로 "주입"되며 DI는 생성자, 설정자 메서드 또는 클래스 내 특정 필드를 통해 수행될 수 있음
- IoC와 DI를 레고 블록으로 애플리케이션을 구축하는 것과 비교할 수 있음
- 스프링은 바닥판 역할을 하며, 개발자는 그 위에서 자신만의 애플리케이션(레고 블록의 독특한 조합)을 조립하는 데 집중

### Bean 이란?

- 자바에서의 JavaBean 데이터를 저장하기 위한 구조체로, JavaBean 규약을 따름
- private 프로퍼티와 getter/setter 메서드로만 데이터에 접근할 수 있도록 함
- 기본 생성자가 없는 인수를 필요로 하지 않음

```java
public class JavaBean {
    private String id;
    private Integer count;

    public JavaBean() {}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }
}
```

### 스프링에서의 Bean

- 스프링 IoC 컨테이너에 의해 생성되고 관리되는 객체
- 자바에서처럼 new Object();로 생성하지 않고, 스프링 컨테이너를 통해 자동으로 관리
- Bean들은 서로 간에 편리하게 의존(사용)할 수 있음

### 스프링 컨테이너 개요

ApplicationContext 인터페이스를 통해 제공되는 스프링 컨테이너는 Bean 객체의 생성 및 Bean들의 조립(상호 의존성 관리)을 담당

### Bean의 등록 및 생명주기

- 과거에는 XML로 설정을 관리하여 Bean을 등록했지만, 현재는 주로 어노테이션(@Bean, @Controller, @Service 등)을 사용하여 Bean을 등록
- Bean 등록 시 정보로는 클래스 경로, Bean의 이름(기본적으로 클래스 이름에서 첫 글자를 소문자로 변경) 등이 포함됨
- Bean의 생명주기 콜백함수로는 @PostConstruct와 @PreDestroy 등이 자주 사용되며 이 함수들은 Bean이 생성되거나 파괴될 때 필요한 작업을 수행함

## 4. 관점지향 프로그래밍 (Aspect Oriented Programming)

AOP는 객체 지향 프로그래밍(OOP)이 다루기 어려운 특정한 문제들을 해결하기 위해 개발된 프로그래밍 패러다임 이며 애플리케이션의 주요 로직에서 분리된 관심사(cross-cutting concerns)를 모듈화하여 관리할 수 있도록 한다. 이는 특정 함수 호출 전후로 공통적인 처리가 필요한 경우에 유용하다. (예를 들어, 로깅, 트랜잭션 관리, 인증과 같은 기능들이 이에 해당함)

### AOP 핵심 개념

- Aspect: 관심사를 모듈화한 것으로, 여러 클래스나 기능에 걸쳐 있는 공통 기능을 관리함(예를 들어, @Transactional은 트랜잭션 관리를 위해 널리 사용됨)
- Advice: Aspect에 의해 적용되는 실제 기능으로, 로깅, 트랜잭션, 인증 등의 기능을 수행함
- Join point: Advice가 적용될 수 있는 특정 위치를 나타냄
- Pointcut: Join point 중에서 특정 Aspect가 적용될 대상을 선택하는 조건식
- Target Object: Advice가 적용될 실제 객체를 지칭함
- AOP Proxy: Aspect를 적용하기 위해 Advice를 추가하는 과정에서 생성되는 대리 객체이며 CGLIB 같은 코드 생성 라이브러리를 사용하여 프록싱 처리를 함
- Weaving: Advice를 실제 비즈니스 로직 코드에 삽입하는 과정을 의미

### AspectJ 지원

AspectJ는 Java에서 AOP를 구현하기 위한 강력한 라이브러리로, Spring AOP와 함께 사용될 수 있다. Spring AOP만으로는 제한된 기능을 제공하지만, AspectJ를 통해 더 다양한 AOP 기능을 사용할 수 있다.

### Aspect의 정의 및 등록

Aspect를 정의하고 스프링의 Bean으로 등록하기 위해 @Aspect와 @Component 어노테이션을 사용한다.

```java
package org.xyz;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class UsefulAspect {
}
```

### Pointcut의 선언 및 결합

Pointcut은 Advice가 적용될 조건을 정의하는 표현식이다.

```java
package org.xyz;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
@Component
public class UsefulAspect {

    @Pointcut("execution(public * *(..))")
    private void anyPublicOperation() {}

    @Pointcut("within(com.xyz.myapp.trading..*)")
    private void inTrading() {}

    @Pointcut("anyPublicOperation() && inTrading()")
    private void tradingOperation() {}
}
```

### Advice의 종류 및 적용

- Before Advice: 특정 조건에 따라 메소드 실행 전에 수행됨
- After Returning Advice: 메소드 실행 후 결과를 반환할 때 수행됨
- Around Advice: 메소드 실행 전후로 필요한 처리를 수행할 수 있음

```java
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.ProceedingJoinPoint;

@Aspect
public class AroundExample {

    @Around("com.xyz.myapp.CommonPointcuts.businessService()")
    public Object doBasicProfiling(ProceedingJoinPoint pjp) throws Throwable {
        // start stopwatch
        Object retVal = pjp.proceed();
        // stop stopwatch
        return retVal;
    }
}
```

## 5. Validation, Data binding

### Validation 이란?

Validation은 사용자 또는 서버로부터 받은 요청의 데이터에 오류가 없는지 검사하는 과정이며 주로 잘못된 형식, 누락된 필수 필드, 또는 비즈니스 로직에 위배되는 입력을 확인하는 데 사용된다.

### Validation의 종류

- 데이터 검증
  - 필수 데이터의 존재 여부
  - 문자열 길이, 숫자 범위 확인
  - 특정 형식의 데이터 검증 (이메일, 신용카드 번호 등)
- 비즈니스 검증
  - 애플리케이션 정책에 따른 데이터 검증
  - 외부 API 호출 또는 데이터베이스 조회를 통한 검증

### 스프링에서의 Validation 방법

스프링은 다양한 방법으로 데이터 검증을 지원한다.

#### Java Bean Validation

JavaBean 내에 어노테이션을 사용하여 데이터 유효성을 검사하는 방법이며 이는 가장 일반적으로 사용되는 방법 중 하나로, 간단하고 선언적인 방식으로 데이터 검증을 수행할 수 있다.

```java
public class MemberCreationRequest {
    @NotBlank(message="이름을 입력해주세요.")
    @Size(max=64, message="이름의 최대 길이는 64자 입니다.")
    private String name;
    @Min(value = 0, message = "나이는 0보다 커야 합니다.")
    private int age;
    @Email(message = "이메일 형식이 잘못되었습니다.")
    private String email;

    // getters and setters...
}
```

이렇게 정의된 요청 DTO에 @Valid 어노테이션을 사용하여 컨트롤러에서 요청 데이터를 검증할 수 있다.

#### Spring Validator 인터페이스

Validator 인터페이스를 구현하여 보다 복잡한 검증 로직을 직접 정의할 수 있으며 유연하지만, 코드 추적과 유지보수가 상대적으로 어려울 수 있다.

```java
public class PersonValidator implements Validator {
    public boolean supports(Class<?> clazz) {
        return Person.class.equals(clazz);
    }

    public void validate(Object obj, Errors errors) {
        ValidationUtils.rejectIfEmpty(errors, "name", "name.empty");
        Person p = (Person) obj;
        if (p.getAge() < 0) {
            errors.rejectValue("age", "negativevalue");
        } else if (p.getAge() > 110) {
            errors.rejectValue("age", "too.darn.old");
        }
    }
}
```

#### Validation 수행 시 주의사항 및 실무 활용 패턴

- 주의사항: Validation 로직이 여러 곳에 흩어져 있으면 중복된 검증 로직 수정, 다른 정책을 따르는 검증 로직 적용 등으로 인해 유지보수가 어려워질 수 있으며 가능한 한 로직 초기에 검증을 수행하고 실패 시 예외를 던지는 방식이 좋음
- 실무 패턴: 데이터 검증 후 비즈니스 검증을 수행하고, 문제가 있을 경우 커스텀 예외를 던져 예외 처리를 통해 응답을 생성하는 패턴이 일반적임

## 6. Resource

스프링은 자바의 기본 URL 클래스의 한계를 넘어, 애플리케이션 내부 및 외부 자원을 효율적으로 접근하기 위해 Resource 추상화를 제공하며 이는 클래스패스, 파일 시스템 및 웹 리소스 등 다양한 위치의 자원에 일관된 방식으로 접근할 수 있게 돕는다.

### Resource Interface와 그 구현체들

스프링의 Resource 인터페이스는 다음과 같은 메서드를 제공하여, 다양한 자원에 대한 접근을 가능하게 한다.

```java
public interface Resource extends InputStreamSource {
    boolean exists();
    boolean isReadable();
    boolean isOpen();
    boolean isFile();
    URL getURL() throws IOException;
    URI getURI() throws IOException;
    File getFile() throws IOException;
    ReadableByteChannel readableChannel() throws IOException;
    long contentLength() throws IOException;
    long lastModified() throws IOException;
    Resource createRelative(String relativePath) throws IOException;
    String getFilename();
    String getDescription();
}
```

### 주요 Resource 구현체

- UrlResource
  - java.net.URL을 래핑하여 다양한 프로토콜(http:, https:, ftp:, file: 등)을 지원함
- ClassPathResource
  - 애플리케이션 클래스패스에 있는 자원에 접근할 때 사용함
- FileSystemResource
  - 파일 시스템에 직접 접근할 필요가 있을 때 사용하는 구현체임
- ServletContextResource, InputStreamResource, ByteArrayResource
  - 각각 서블릿 컨텍스트, 입력 스트림 및 바이트 배열에서 자원을 로드할 때 사용함

### Spring의 ResourceLoader

ResourceLoader는 스프링 컨텍스트 내에서 리소스를 로딩하는 역할을 한다. ApplicationContext는 ResourceLoader의 기능을 상속받아, 다양한 유형의 리소스 로딩을 지원한다.

```java
@Service
public class ResourceService {
    @Autowired
    ApplicationContext ctx;

    public void setResource() {
        Resource myTemplate = 
            ctx.getResource("classpath:some/resource/path/myTemplate.txt");
        // 사용할 리소스를 로드
    }
}
```

### ResourcePatternResolver

ResourcePatternResolver는 ApplicationContext에서 사용되며, 패턴을 기반으로 한 리소스 로딩을 지원한다. 이 인터페이스를 통해, classpath*: 또는 file: 등의 패턴을 사용하여 리소스를 효율적으로 로드할 수 있다.

### Application Contexts & Resource Paths

애플리케이션 컨텍스트를 설정하고 리소스 패스를 관리하는 방법

```java
ApplicationContext ctx = new ClassPathXmlApplicationContext("conf/appContext.xml");
ApplicationContext ctx = new FileSystemXmlApplicationContext("conf/appContext.xml");
ApplicationContext ctx = new FileSystemXmlApplicationContext("classpath:conf/appContext.xml");
```

## 7. Spring Expression Language(SpEL)

SpEL은 스프링 프레임워크 전반에 걸쳐 사용되는 표현 언어이며 이는 설정 값, 객체의 속성, 조건식 등을 효과적으로 처리하고 다룰 수 있게 해주며, 강력하면서도 유연한 방식으로 표현식을 작성할 수 있다.

### SpEL의 특징과 활용

SpEL은 문자열, 메서드 호출, 타입 참조 등 다양한 프로그래밍 구조를 간결한 표현으로 다룰 수 있다. 주로 설정 값의 동적 주입, 런타임 시 객체 그래프 조회와 조작, 조건에 따른 빈 설정 변경 등에 활용된다.

```java
ExpressionParser parser = new SpelExpressionParser();
Expression exp = parser.parseExpression("'Hello World'");
String message = (String) exp.getValue();  // 결과: "Hello World"

Expression expWow = parser.parseExpression("'Hello World'.concat('!')");
String messageWow = (String) expWow.getValue();  // 결과: "Hello World!"

Expression expString = 
    parser.parseExpression("new String('hello world').toUpperCase()");
String messageString = expString.getValue(String.class);  // 결과: "HELLO WORLD"
```

### Bean의 Property 설정에 SpEL 사용

SpEL은 빈의 프로퍼티 값을 설정할 때 매우 유용하게 사용된다. 설정 파일에서 값 가져오기, 표현식을 통한 값 계산 및 조건부 논리 적용이 가능하다.

```java
@Component
public class SimpleComponent {
    @Value("#{1+1}")
    int two;  // 값: 2

    @Value("#{2 eq 2}")
    boolean isTrue;  // 값: true

    @Value("${server.hostname}")
    String hostName;  // 예: "www.server.com"

    @Value("#{${server.hostname} eq 'www.server.com'}")
    boolean isHostSame;  // 값: true
}
```

#### 주요 활용법

- 직접적인 값 설정: SpEL을 사용하여 직접적인 값 계산이나 조건 평가를 통한 빈의 프로퍼티 값 할당
- 환경변수와의 통합: @Value 어노테이션과 함께 환경 설정 파일의 값에 접근하거나, 그 값에 기반한 조건 로직 적용
- 메서드 및 연산자 사용: SpEL 내에서 메서드 호출, 연산자 사용을 통해 복잡한 로직을 간단하게 표현

## 8. Null Safety

널 안정성은 자바 및 스프링 프레임워크에서 중요한 개념 중 하나로, 프로그램에서 Null Pointer Exception (NPE)을 방지하는 데 중점을 둔다. 이를 위해 스프링은 명시적인 어노테이션을 통해 널 관련 문제를 예방하고 코드의 안정성을 높이는 방법을 제공한다.

### 널 체크를 하지 않는 코드의 문제점

자바에서는 null 참조에 대한 접근 시 NullPointerException이 발생한다. 이를 방지하기 위해 개발자는 종종 null 체크 로직을 추가하게 되는데, 이 방식은 코드의 복잡성을 증가시킬 수 있다.

### @NonNull과 @Nullable 어노테이션 사용

`@NonNull` 어노테이션은 메서드의 파라미터, 반환값, 또는 필드가 null이 아니어야 함을 명시한다. 이 어노테이션은 null 값이 할당되거나 전달되지 않도록 강제하여, 런타임에 NPE가 발생하는 것을 사전에 방지할 수 있다.

- 메서드 파라미터: null을 허용하지 않으므로 메서드 내부에서 null 체크를 생략할 수 있음
- 필드: 해당 필드에 null 값이 저장되는 것을 방지함
- 메서드 반환값: 메서드가 null을 반환하지 않을 것임을 보장함

`@Nullable` 어노테이션은 변수, 파라미터 또는 반환값이 null일 수 있음을 명시한다. 이 어노테이션이 적용된 요소를 사용할 때는 반드시 null 체크를 수행해야 하며, 개발 도구는 이를 강조하여 알려준다.

Null Safety의 이점

- 명확한 계약: @NonNull과 @Nullable 어노테이션은 메서드나 필드의 사용 방법에 대해 명확한 계약을 제공함
- 이로써 개발자가 API를 더 안전하고 일관되게 사용할 수 있도록 도움
- 에러 방지: 널 체크 로직을 명시적으로 관리함으로써 런타임 에러의 가능성을 크게 감소시킴
- 코드 품질 향상: 명시적인 널 처리 규칙을 통해 더 깨끗하고 관리하기 쉬운 코드를 작성할 수 있음

# Clean Architecture

## Flutter Clean Architecture

* 코드의 유지 보수성과 확장성을 향상시키기 위해 코드를 구조화하는 방법
* 독립적인 레이어로 구성되며, 각 레이어는 특정한 역할을 수행
* Presentation, Domain, Data 3가지 레이어로 구성됨
  * 세가지 레이어는 서로 다른 책임을 가지고 있음
  * 각 레이어는 서로 독립적이며 변경 사항이 다른 레이어에 영향을 미치지 않음

### Presentation Layer

* UI, Widget 및 관련 뷰 코드를 담당
* 사용자의 입력을 수신하고 출력을 제어함
* Flutter에선 Stateful/Stateless Widget으로 구현

### Domain Layer

* 앱의 비즈니스 로직과 업뮤 규칙을 정의함
* 특정 플랫폼과 무관함
* UI, DB와 같은 외부 요소와 독리적
* Entity
  * 앱의 핵심 개념을 나타내는 객체
* Repository Interface
  * 데이터 액세스 추상화 레이어
* Use Case
  * 프로그램 동작을 나타내는 단위

### Data Layer

* 데이터 액세스, 데이터 저장소 및 외부 API와의 상호 작용과 관련된 코드 담당
* 앱에서 사용되는 데이터 관리하고 Domain Layer와 상호작용함
* Repository Interface구현
* 서버 API 및 로컬 캐시와 같은 외부 리소스에 액세스
* Remote Data Source
  * 원격 데이터 소스, 서버 API를 사용하여 데이터를 가져옴
* Local Data Source
  * SQLite, SharedPReferences 또는 파일 시스템과 같은 로컬 스토리지를 사용하여 데이터를 가져옴

---

### DTO (Data Transfer Object)

* 데이터 전송 객체
* 앱의 다양한 계층 간 데이터 전송을 처리하는 데 사용
* 보통 RESTful API를 통해 데이터를 가져오거나 저장하는 데 사용됨
* 데이터 모델
  * 앱에서 사용되는 데이터를 표현하는 객체
  * 보통 JSON or XML 형식으로 표현
* 매핑 로직
  * 데이터를 전달할 때 데이터 모델과 앱의 다른 계층 간의 매핑 로직 제공
  * DTO가 데이터 모델과 앱의 다른 계층간의 인터페이스 역할
* 유효성 검사
  * 데이터의 유효성 검사
  * Flutter의 DTO 처리
    * json_serializable
      * JSON 직렬화, 역직렬화 처리 라이ㅡ러리
      * Dart Class to JSON, JSON to Dart Class
    * equatable
      * 객체의 동등성 비교 처리 라이브러리
      * 객체의 동등성을 비교하고 필요에 따라 상태 변경 처리

---

### DAO (Data Access Object)

* 데이터 접근 객체
* 데이터베이스와의 상호작용을 담당하는 객체
* CRUD 작업을 처리하기 위해 사용
* 인터페이스
  * 데이터 베이스와의 상호작용을 담당하는 인터페이스를 정의
  * 이를 통해 다른 계층에서 DAO 구현 세부사항을 알 필요 없어짐
  * 인터페이스만 사용하여 데이터베이스와 상호작용
* 데이터모델
  * 데이터베이스에서 사용되는 데이터 모델 정의
  * 데이터베이스와 상효작용 할 때 사용되는 모델을 일관되게 사용하도록함
* 구현 로직
  * 데이터베이스와 상호작용에 필요한 구현 로직을 제공
  * 일반적으로 데이터 CRUD 메서드 포함됨
  * sqflite
    * 데이터베이스와 상호작용하는 라이브러리
    * SQLite 데이터베이스와의 상호작용을 쉽게 처리하도록 도와줌
  * floor
    * SQLite 데이터베이스와 상호작용하는 ORM(Object Releation Mapping)라이브러리
    * SQLite 데이터베이스와으 상호작용을 쉽고 간결하게 처리할 수 있음
  * Hive
    * 빠르고 경량화된 NoSQL 데이터베이스 라이브러리
    * 메모리에 데이터를 저장하며 필요할 때 디스크에 저장
    * key-vlaue 형식의 데이터 저장
    * 다른 NoSQL 데이터베이스와 달리 모든 데이터가 하나의 파일로 저장됨
    * 별도의 서버구성이 필요하지 않음
    * 높은 성능
      * 메모리에 데이터 저장 / 필요시 디스크에 저장 하여 메우 빠른 속도 제공
    * 경량화
      * 추가적인 종속성이 거의 없어 앱의 크기를 줄일 수 있음
    * 다양한 데이터 형식 지원
    * 호환성
      * 다른 데이터베이스와 호환성이 높음
      * 다른 데이터베이스와의 상호작용을 쉽게 처리

---

### Entity

* 비즈니스 로직과 관련된 데이터 객체
* 데이터베이스와 상호작용하는데 사용되는 데이터 모델
* 일반적으로 데이터와 관련된 필드를 가지며 데이터베이스에 저장될 때 데이터베이스 열에 매핑됨
* 비즈니스 로직과 관련된 데이터를 캡슐화하여 데이터의 일관성을 유지
* 데이터베이스와 관련된 코드를 캡슐화하여 데이터베이스 변경에 유연하게 대처
* Flutter Entity
  * 일반적으로 클래스를 사용하여 구현
  * Entity 필드를 정의하고 생성자를 정의하여 데이터 초기화
  * 데이터베이스와 상호작용하는 메서드 포함
* Clean Architecture 및 MVVM과 같은 아키텍처 패턴에서 중요한 역할
* 비즈니스 로직, 데이터를 캡슐화하여 앱의 다른 계층에서 사용될 수 있도록 혀용
* 애의 모듈성과 유지 보수성 향상

---

### part

"../02 [Inflern] Flutter Clean Architecture ""../02 [I] Flutter Clean Architecture "* 코드를 여러 파일로 분할할 수 있게 해주는 기으
* dart 언어의 일부분이며 하나의 파일을 여러 부분으로 분할
* 하나의 파일에 모든 코드를 작성하면 파일의 크기가 커져 코드를 관리하기 어려워짐

### extension

* 기존 클래스에 새로운 메서드를 추가하는 기능 제공
* 기존 클래스를 확장하여 새로운 기능 추가
* 상속보다 더 유연한 방식으로 클래스 확장

### factory

* 생성자를 정의하는 또 다른 방법
* 생성자에서 새로운 객체를 생성하는 대신 기존 객체를 재상용하여 반환
* 메모리 절약 및 성능향상
* 생성자 정의
  * 생성사 정의시 반환형을 지정함
  * 반환형으로 지정된 클래스의 인스턴스를 반환
  * 새로운 객체를 생성하지 않고 기존 객체를 재사용하거나 다른 객체를 생성하여 반환

### dynamic

* 변수 타입을 지정하지 않고 사용할 수 있게 해주는 키워드
* 어떤 타입의 값이라도할당할 수 있음
* 안전성이 떨허지기 때무에 되도록 사용하지 않는것이 좋음
* 필요한 경우
  * 타입이 명확하지 않은 외부 라이브러리 사용시
  * 타입을 지정하지 않고 다양한 타입의 값을 저장해야 할 때
* 주의사항
  * 타입 검사를 하지 않기 때문에 안정성이 떨어질 수 있음
  * 타입을 명시적으로 지정할 수 없기 때문에 가독성이 떨어질 수 있음
  * 타입을 기반으로한 최적화가 이루어지지 않을 수 있음

### Debounce

* 이벤트 발생 후 일정 시간 동안 이벤트를 무시하는 기술
* 텍스트 필드에 입력이 변경될 때 마다 API를 호출하는 경우 사용
  * API 호출을 지연시켜 네트워크 트래픽과 서버 부하를 줄임
* Timer
  * 가장 간단한 방법
  * 이벤트 발생 후 특정 시간 동안 에빈트를 무시
* Rxdart
  * 가장 인기있는 라이브러리
  * 코드 작성없이 특수 연산자 사용하여 구현

```dart
// timer
final debouncer = Debouncer(duration: Duration(milliseconds: 200));
TextEditingController controller = TextEditingController();
controller.addListener(() {
  debouncer.run(() {
    // 입력이 변경된 후 200밀리초 후에 이 코드가 실행됩니다.
  });
});

// rxdart
final _debouncedText = BehaviorSubject<String>();
_debouncedText.add(query);
_debouncedText
  .debounceTime(const Duration(milliseconds: 500))
  .listen((event) {
    _getCompanyListings(query: event);
  });
```

### covariant

* Dart 유형 시스템
* 함수 또는 필드의 유형이 하위 유형으로만 제한될 수 있음을 나타내는 데 사용
* 위젯 트리에서 유용
  * StatefulWidget을 확장하는 MyWidget이 있는 경우
  * build()라는 Widget을 받는 함수가 있음
  * covariant 키워드를 사용하여 함수의 유형을 covariant Widget으로 지정할 수 있음
  * MyWidget의 하위 유형만 build() 함수의 인수로 사용할 수 있음
  * MyWidgetd의 하위 유형이 build() 함수에 자신을 전달할 수 있음을 의미함
  * 하위 유형에서 build()를 재정의할 수 있음

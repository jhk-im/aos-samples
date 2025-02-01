# provider_overview_01

Why do we need a package like provider?

```text
#inversion of control
함수의 레퍼런스를 child widget에 전달하여 호출하는 것이다.
```

## 극명한 문제점

1. inversion of control 발생 -> increment()를 MyHomePage 위젯에 정의할수 밖에 없음
2. Middle 위젯은 오로지 counter를 전달하기 위한 용도로 입력받음
3. MyHomePage widget에서 setState를 호출하는데 하위 위젯이 전부 리빌드됨
4. UI 리빌딩 로직이 실제 리빌딩이 발생하는 위젯이 아닌 상위 위젯에 있으므로 찾기가 어려워짐

### State Management

1. 오브젝트를 위젯트리상에서 쉽게 액세스할 수 있도록함 -> Dependency Injection

2. Synchronizing data and UI

```text
Provider는 State를 핸들링하는 특정한 방법을 강요하지 않는다.
(bloc, redux등은 Dependency Injection방법 외에 특정한 방법을 제시함)핸들링하는 수단을 제공할 뿐 어떻게 핸들링해야 한다는 방법론을 제시하지는 않는다.

Provider는 그 자체로 위젯이므로 위젯트리 어디에든 필요한 곳에서 삽입하여 사용할수 있다.
```

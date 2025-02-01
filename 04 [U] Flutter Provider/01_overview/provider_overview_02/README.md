# provider_overview_02

Accessing data easily using provider

## Provider constructor

```text
required Create<T> create
* Provider create property -> 위젯이 필요로하는 오브젝트의 인스턴스를 생성함
* Provider 하위 위젯들은 create에서 생성된 인스턴스에 액세스 가능

Provider.of<T>(context)
* of -> static 메소드이며 상위 위젯을 탐색하여 원하는 타입의 인스턴스를 찾아줌
* context -> context를 활용하여 상위 위젯을 탐색
```

### 보완점

1. grow 함수 실행 후 print는 호출했지만 setState를 호출하지 않아서 UI는 변경되지 않았다.

2. Provider에서 setState와 같이 UI를 다시 그리도록 플러터에게 알려주는 방법을 적용 해야한다.

# provider_overview_06

## MultiProvider

```dart
ChangeNotifierProvider<T>(
  create: (context) => T(),
  child: ChangeNotifierProvider<S>(
    create: (context) => S(),
    child: ChangeNotifierProvider<R>(
      create: (context) => R(),
      child: WidgetA(),
    )
  )
)
```

만약 WidgetA에서 3개의 Provider가 필요하다고 가정해보자. 이미 위젯 뎁스가 깊은데 여기에 하나의 Provider가 더 추가되면 더욱 깊어지게 된다. 이러한 경우에 `MultiProvider`를 사용한다.

SyntacticSugar -> 기능은 동일하지만 문법적으로 보기 편하게 해주는 것을 의미한다.

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider<T>(
      create: (context) => T(),
    ),
    ChangeNotifierProvider<S>(
      create: (context) => S(),
    ),
    ChangeNotifierProvider<R>(
      create: (context) => R(),
    ),
  ],
  child: WidgetA(),
)
```

## FutureProvider

FutureBuilder로 대체하여 사용할 수 있다.
사용해야 할 인스턴스가 아직 준비되지 않은 경우 대기할 때 사용하는 Provider이다.

```dart
FutureProvider(
  Key? key,
  required Create<Future<T>?> create,
  required T initalData,
),
```

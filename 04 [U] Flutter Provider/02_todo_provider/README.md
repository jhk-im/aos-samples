# todo_provider

## Equatable Package

```dart
class A {
    final int a;
    A(this.a);

    final a1 = A(1);
    final a2 = A(1);
    print(a1 == a2); // false
}
```

- Overriding equality operator ==
- Overriding hasCode of a class
- 위와 같은 번거로움을 덜어주는 패키지이다.
- 따로 학습해볼 것을 권장

## states

- Independent States
  - ChangeNotifierProvider

- Computed States
 - ChangeNotifierProxyProvider
 - ProxyProvider
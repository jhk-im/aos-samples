# provider_overview_07

## StreamProvider

FutureProvider보다 사용 빈도가 높다.
`Firebase`에서 많이 사용되며 Battery Level을 지속적으로 체크하거나 Stock Price를 주기적으로 업데이트 하는 등의 경우에서 사용한다.

`StreamBuilder`를 사용할 수 있지만 스트림 값을 여러 위젯에서 사용하고 싶은경우 `StreamProvider`를 사용하면 더 편리하다.

```dart
StreamProvider(
  Key? key,
  required Create<Stream<T>?> create,
  required T initialData,
)
```

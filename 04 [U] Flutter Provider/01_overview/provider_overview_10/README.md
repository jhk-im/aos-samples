# provider_overview_10

## Selector

Consumer위젯과 유사하지만 좀 더 상세하게 컨트롤하는 기능을 제공한다.
A타입의 오브젝트를 받아서 S타입으로 반환하고 반환된 S로 위젯을 생성하여 반환한다.
select extension method와 매우 유사하다.

```dart
Selector({
    Key? key,
    required ValueWidgetBuilder<S> builder,
    required S selector(BuildContext, A),
})
```

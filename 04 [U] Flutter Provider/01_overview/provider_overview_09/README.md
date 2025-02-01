# provider_overview_09

## ProviderNotFoundException

builder property
Text위젯이 Provider위젯에 접근할 수 있도록 중간에 Builder위젯을 추가한다.

```dart
Provider<int>(
    create: (context) => 42,
    child: Builder(
        builder: (context) {
            final value = context.watch<int>();
            return Text('$value');
        }
    )
)

// Syntac sugar
Provider<int>(
    create: (context) => 42,
    builder: (context, child) {
        final value = context.watch<int>();
        return Text('$value');
    }
)
```

Cousumer를 사용해도 Builder와 정확하게 동일한 동작을 한다. 근본적으로 Consumer에서도 Builder패턴을 사용하기 때문이다.

ProviderNotFoundException 옵션

1. 위젯 트리상으로 더 위로 올린다.
2. Builder를 사용한다.
3. Consumer를 사용한다.

상황에 맞는 옵션을 사용한다.

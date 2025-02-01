# provider_overview_12

## Provider Access

MaterialApp특징 중 Navigator push로 이동하는 경우 child위젯이 생성되는 것이 아니라 새로운 위젯트리가 생성된다.

Anonymous route access는 Route이름 없이 다이나믹하게 생성된다.

```dart
Navigator.push(
    context,
    MaterialPageRoute(builder: (_) {
        return ChangeNotifierProvider.value(
            value: context.read<Counter>(),
            child: const ShowMeCounter(),
        );
    }),
);
```

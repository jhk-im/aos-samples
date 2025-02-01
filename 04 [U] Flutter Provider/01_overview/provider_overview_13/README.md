# provider_overview_13

## Provider Access

Named route access

```dart
routes: {
    '/': (context) => ChangeNotifierProvider.value(
        value: _counter,
        child: const MyHomePage(),
    ),
    '/counter': (context) => ChangeNotifierProvider.value(
        value: _counter,
        child: const ShowMeCounter(),
    ),
},
```

_counter(ChangeNotifier)를 ChangeNotifierProvider를 통해 생성하지 않았기 때문에 MyApp을 StatefulWidget으로 변경하여 별도로 close해준다.

```dart
@override
void dispose() {
    _counter.dispose();
    super.dispose();
}
```

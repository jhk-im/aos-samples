# provider_overview_14

## Provider Access

Generate route access

```dart
onGenerateRoute: (RouteSettings settings) {
    switch (settings.name) {
        case '/':
            return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                value: _counter,
                child: const MyHomePage(),
              ),
            );
        case '/counter':
            return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                value: _counter,
                child: const ShowMeCounter(),
              ),
            );
        default:
            return null;
    }
},
```

Global access

앱이 커지고 팀이 분할될수록 모든 클래스를 Global access로 만드는 것은 바람직하지 않다.

```dart
return Provider<T>(
    create: (_) => T(),
    child: MaterialApp(
        ...,
    ),
)
```

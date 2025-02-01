# provider_overview_17

## 구현 1

호출한 함수내에서 처리하는 방식이다.

app_provider.dart

```dart
  Future<void> getResult(/*BuildContext context, */ String searchTerm) async {
    _state = AppState.loading;
    notifyListeners();

    final navigator = Navigator.of(context);

    await Future.delayed(const Duration(seconds: 1));

    try {
      if (searchTerm == 'fail') {
        throw 'Something went wrong';
      }

      _state = AppState.success;
      notifyListeners();

      navigator.push(
        MaterialPageRoute(builder: (context) {
          return const SuccessPage();
        }),
      );
    } catch (e) {
      _state = AppState.error;
      notifyListeners();
      
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Something went wrong'),
          );
        },
      );
    }
  }
```

## 구현 2

에러가 발생한 시점에서 다이얼로그 표시하는 방식이다.

build내에서 다이얼로그 표시나 네비게이션 이동과 같은 로직을 실행하는 것은 권장하지 않는다. build함수는 생각보다 여러번 호출될 수 있기 때문이다.

main.dart

```dart
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppProvider>().state;

    if (appState == AppState.success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const SuccessPage();
          }),
        );
      });
    } else if (appState == AppState.error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Something went wrong'),
            );
          },
        );
      });
    }

    ...
  }
```

## addListener of ChangeNotifier

UI와 비즈니스 로직이 섞이지 않도록 하기위해 ChangeNotifier addListener를 사용하여 구현한다. 리스너를 등록하고 해제하는 보일러플레이트 코드가 추가되는 단점이 있다.

```dart
class _MyHomePageState extends State<MyHomePage> {
  ...
  late final AppProvider appProv;

  @override
  void initState() {
    super.initState();
    appProv = context.read<AppProvider>();
    appProv.addListener(appListener);
  }

  void appListener() {
    if (appProv.state == AppState.success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const SuccessPage();
        }),
      );
    } else if (appProv.state == AppState.error) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Something went wrong'),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    appProv.removeListener(appListener);
    super.dispose();
  }

  ...
}
```

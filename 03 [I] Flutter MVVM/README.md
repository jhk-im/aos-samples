# MVVM (Model + View + View Model)

## MVVM

* UI레이어와 비즈니스 로직을 분리
* Model: 앱에서 사용하는 데이터 모델
* View
  * 사용자에게 표시되는 UI
  * 사용자의 액션을 ViewModel에 전달
* ViewModel:
  * View와 Model 사이에서 상호작용
  * View에 표시할 데이터 제공
  * Model 업데이트 관리
  * 상태변경 알림 수신
  * View로부터 전달된 액션을 처리하고 Model로 부터 데이터를 가져옴
  * View와 Model사이 결하도를 낮춤
* Flutter에선 Provider 패키지를 사용하여 구현

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class CounterModel {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
  }
}

class CounterViewModel {
  final CounterModel _model;

  CounterViewModel(this._model);

  int get count => _model.count;

  void increment() {
    _model.increment();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterViewModel(CounterModel()),
      child: MaterialApp(
        title: 'Flutter MVVM Example',
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CounterViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter MVVM Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Count:',
            ),
            Text(
              '${viewModel.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.increment();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
```

* CounterModel
  * count 변수, increment() 메서드 보유
* CounterViewModel
  * CounterModel 인스턴스를 가지고 있음
  * CounterModel 데이터를 View로 전달하고 사용자 액션을 CounterModel에 전달
  * ChangeNotifier를 상속
  * increment()메서드 호출시 notifyListners() 메서드를 호출하여 변경상태 알림

### ensureVisualUpdate

* UI업데이트가 지연되거나 일시적으로 차단되는 경우 사용
* 현재 빌드 중인 UI 구성요소 상태를 업데이트
* 새로운 상태가 즉시 반영되도록 보장
* UI 업데이트가 지연되거나 차단되더라도 올바른 정보를 표시하도록 보장
* 매우 빠르게 실행되는 메서드이므로 성능에 부담을 주지 않음
* 가능한 경우 사용하는 것을 권장

```dart
void main() {
  WidgetsFlutterBinding().ensureVisualUpdate();
  runApp(ChangeNotifierProvider.value(
    value: StoreViewModel(), child: const MyApp(),));
}
```

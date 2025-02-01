# provider_overview_03

Listen for data changes using addListener of ChangeNotifier

## ChangeNorifier

플러터 위젯들은 ChangeNotifier를 extend하거나 ChangeNotifier와 mixin한 오브젝트 인스턴스를 listen할 수 있다.

```dart
class Counter with ChangeNotifier {
    int counter = 0;
    increment() {
        count++;
        notifyListeners(); // ChangeNotifer를 listen하고 있는 모든 인스턴스에 변동사항을 알려줌
    }
}

final myCounter = Counter();
myCounter.addListener(() { // 콜백 함수를 등록하면 notifyListeners()가 호출될 때마다 실행됨
    print('counter: ${myCounter.counter}');
});

// 추가된 리스너는 자동으로 dispose되지 않으므로 수동으로 dispose해주어야함
@override
initState() {
    super.initState();
    myCounter.addListener(myListener);
}

myListener() {
    print('counter: ${myCounter.counter}');
}

@override
dispose() {
    myCounter.removeListener(myListener);
    super.dispose();
}
```

### 보완점

1. 여전히 변한 값이 UI에 반영되지 않음

2. Dog 인스턴스를 위젯을 통해서 계속 전달해 주어야 함

3. 매번 수동으로 리스너를 등록하고 삭제하는 작업을 반복하게 됨

4. Provider와 ChangeNotifier는 결과적으로 반쪽자리 -> ChangeNotifierProvider 사용

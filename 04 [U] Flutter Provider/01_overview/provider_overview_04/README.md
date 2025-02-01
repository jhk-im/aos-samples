# provider_overview_04

## ChangeNotifierProvider

ChangeNotifier + Provider

1. ChangeNotifier의 인스턴스 생성한다.

    * 인스턴스를 필요할 때 만든다. (lazy)
    * 필요 없어지면 메모리에서 제거한다.

2. ChangeNotifer가 필요한 위젯에 쉽게 접근할 수 있는 수단을 제공하고 필요시 UI를 리빌드한다.

    * constructor를 통해 인스턴스를 전달할 필요없이 Provider.of를 통해 인스턴스에 접근할 수 있다.

    * Provider.of`<`T`>`(context, listen: false) -> 액세스만 하고 UI재생성은 하지 않는다. 이러한 경우도 종종 발생하기 때문에 유용한 기능이다.

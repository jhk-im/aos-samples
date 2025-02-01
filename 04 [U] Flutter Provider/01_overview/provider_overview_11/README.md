# provider_overview_11

## ProviderNotFoundException 2

옵션

* Child 위젯으로 감싼다.
* Builder위젯으로 감싼다.

Builder위젯 콜백에 전달되는 context는 Builder 자체의 context이다. Builder는 ChangeNotifierPorvider의 child이다. 주어진 Builder의 context를 따라 위로 올라가면 Counter타입의 ChangeNotifierProvider를 찾을 수 있다.

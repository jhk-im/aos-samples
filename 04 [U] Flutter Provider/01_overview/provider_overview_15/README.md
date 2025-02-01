# provider_overview_15

## ProxyProvider

Provider는 위젯에 위젯이 아닌 오브젝트를 전달해주는 역할을 한다.
만약 특정 Provider에서 다른 Provider의 오브젝트에 접근해야 한다면 어떻게 해야할까?
이를 가능하게 해주는 것이 `ProxyProvider`이다.
기본 Provider와 마찬가지로 ProxyProvider에도 여러 종류의 Provider가 존재한다.

ProxyProvider는 다른 Provider의 value에 의존하기 때문에 value변경시 update해야하므로 update는 여러번 create는 한번만 호출되도록 되어있다.

```dart
// constructor
ProxyProvider({
  Key? key,
  Create<R>? create,
  required ProxyProviderBuilder<T, R> update,
  UpdateShouldNotify<R>? updateShouldNotify,
  Dispose<R>? dispose,
  bool? lazy,
  TransitionBuilder? builder,
  Widget? child,
}),
```

update가 호출되는 경우

* ProxyProvider가 의존하는 Provider의 value를 처음 획득 했을때

* 의존하는 Provider의 value가 변경될 때마다

* ProxyProvider가 rebuild할 때

* 어떠한 Provider가 변화하는 값에 의존하는 경우

### update callback

```dart
typedef ProxyProviderBuilder<T, R> = R Function(
  BuildContext context,
  T value,
  R? previous,
)
```

왜 R은 nullable인가? create가 optional이기 때문이다.

### ProxyProviderN

```dart
typedef ProxyProviderBuilder2<T, T2, R> = R FunctionI(
  BuildContext context,
  T value,
  T2 value2,
  R? previous,
)
```

T2가 추가되었다는 점이 다르다. ProxProvider는 0~6까지 있다. `ProxyProviderN`이라는 것은 ProxyProvider0의 syntactic sugar다.

```dart
/* 
  ProxyProvicer<A, result>라는 것은 ProxyProvider0의 update callback에서 
  위젯 트리 상에서 A라는 오브젝트의 인스턴스를 읽고 a라는 변수에 저장 후
  다시 update함수를 호출하는데 a가 2번째 argument로 들어간다.
*/
ProxyProvider0<Result>(
  update: (BuildContext context, Result result) {
    final A a = Provider.of<A>(context);
    return update(BuildContext context, A a, Result result);
  }
)

// 동일한 내용
ProxyProvider0<Result>(
  update: (BuildContext context, Result result) {
    final A a = Provider.of<A>(context);
    final B b = Provider.of<B>(context);
    return update(BuildContext context, A a, B b, Result result);
  }
)
```

ProxyProvider0를 사용하면 ProxyProvider100도 생성할 수 있다.

### ChangeNotifierProxyProvider

`ChangeNotifierProxyProvider`는 외부 ChangeNotifier와 값을 synchronizes한다.

```dart
/*
  create는 한번 호출되므로 liste: false로 설정한다.
  MyChangeNotifier를 생성할때 MyModel에 의존하여 생성하게 된다.
  이 경우 MyModel이 변경될 때 MyChangeNotifier를 update할 방법이 없다.
*/
ChangeNotifierProvicer(
  create: (BuildContext context) {
    return MyChangeNotifier(myModel: Provider.of<MyModel>(context, listen: false));
  },
  child: ...,
)

/*
  MyModel이 update될 때 마다 MyChangeNotifier가 update되는데 인스턴스를 다시 생성하는 것이 아니라 기존의 인스턴스를 계속 사용한다는 의미이다.
*/
ChangeNotifierProxyPrivcer<MyModel, MyChangeNotifier>(
  create: (_) => MyChangeNotifier(),
  update: (_m MyModel myModel, MyChangeNotifier myChangeNotifier) => myChangeNotifier..update(myModel),
  child: ...,
)

// 구현예시
class MyChangeNotifier with ChangeNotifier {
  void update(MyModel myModel) {
    // Do some custom work based on myModel that may call notifyListners()
  }
}
```

### 주의사항

1. ChangeNotifier를 update에서 직접적으로 생성하면 안된다.
  
    * 의존하고 있는 값이 update될 때 state를 잃어버릴 수 있다.
      * MyChangenotifer 내부에 async를 사용하고 있는 경우 async가 끝나기 전에 update가 먼저 실행될 수 있다.

2. 가능하면 ProxyProvider를 사용하는 것이 좋다.

    * 생성된 오브젝트가 http호출과 같은 side-effects없이 다른 object들의 combination으로만 이루어진다면 ProxyProvider를 사용하여 immutable한 오브젝트를 만드는 것을 권장한다.

### Why ProxyProvider

왜 UI업데이트 되지 않았는가?
Provider의 create는 한번만 호출되기 때문이다.

값이 변경될 때 Provider의 값을 업데이트하기 위해 ProxyProvider를 사용한다.

```dart
Provider<Translations>(
  create: (_) => Translations(counter),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const ShowTranslations(),
      const SizedBox(height: 20.0),
      IncreaseButton(increment: increment),
    ],
  ),
),
```

### ProxyProvider update

* ProxyProvider는 의존하는 value가 변하면 update가 호출된다.

* ProxyProvider가 리빌드될 때 update가 호출된다.

```dart
ProxyProvider0<Translations>(
  update: (_, __) => Translations(counter),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const ShowTranslations(),
      const SizedBox(height: 20.0),
      IncreaseButton(increment: increment),
    ],
  ),
),
```

### ProxyProvider create/update

update만 사용했을 때와 차이가 없으므로 굳이 이렇게 구현할 필요는 없어보인다.

```dart
        ProxyProvider0<Translations>(
          create: (_) => Translations(),
          update: (_, Translations? translations) {
            translations!.update(counter);
            return translations;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              ShowTranslations(),
              const SizedBox(height: 20.0),
              IncreaseButton(increment: increment),
            ],
          ),
        ),
```

### Multiple ProxyProvider

첫번째 프로바이더는 변경된 value를 반환하고, 다른 하나는 반환된 value를 받아서 새로운 오브젝트를 생성한다.

*권장하는 방식

```dart
        MultiProvider(
          providers: [
            ProxyProvider0<int>( // 제로는 자체적으로 관리하는 데이터가 없으므로, create를 사용할 필요가 없음
              update: (_, __) => counter,
            ),
            ProxyProvider<int, Translations>(
              update: (_, value, __) => Translations(value),
            ),
          ],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ShowTranslations(),
              const SizedBox(height: 20.0),
              IncreaseButton(increment: increment),
            ],
          ),
        ),
```

### ChangeNotifierProvider & ChangeNotifierProxyProvider

Translations 인스턴스는 Counter 인스턴스에 의존한다. 그렇기때문에 create에서 Translations를 생성하고 update에서 Counter가 변경될 때 마다 Translations의 update를 호출하고 뮤테이션한 Translatiosn를 반환한다.

```dart
        MultiProvider(
          providers: [
            ChangeNotifierProvider<Counter>(
              create: (_) => Counter(),
            ),
            ChangeNotifierProxyProvider<Counter, Translations>(
              create: (_) => Translations(),
              update: (
                BuildContext _,
                Counter counter,
                Translations? translations,
              ) {
                translations!.update(counter);
                return translations;
              },
            ),
          ],
        ),
```

### ChangeNotifierProvider & ProxyProvider

ChangeNotifierProxyProvider와 다른 점은 뮤테이션된 Translations을 반환하는 것이 아닌 새로 생성한 Translations을 반환한다는 것이다.

```dart
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => Counter(),
            ),
            ProxyProvider<Counter, Translations>(
              update: (_, counter, __) => Translations(counter.counter),
            ),
          ],
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTranslations(),
              SizedBox(height: 20.0),
              IncreaseButton(),
            ],
          ),
        ),
```

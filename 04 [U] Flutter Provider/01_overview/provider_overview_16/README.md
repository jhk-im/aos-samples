# provider_overview_16

## ProviderNotFound Exception

* hot restart

* route 관련 오류

* BuildContext를 잘못 사용한 경우

## counter_page.dart

프레임워크가 현재 위젯을 그리고있는데 위젯을 추가로 그려달라고 요청해서는 안된다는 의미이다.

```zsh
setState() or markNeedsBuild() called during build.
...
cannot be marked as needing to build because the framework is already in the process of building widgets.
...
```

`StatefulWidget rendering process`

* Create an element (BuildContext)
* initState
* didChangeDependencies
* Build
* 페이지 완성이후 다른 위젯을 그릴 수 있음

`주의할점`

* initState
  
  * 페이지 렌더링을 진행하는 중인 단계
  * 따라서 context에 무언가를 그리라고 요청할 수 없음

* 화면에 무언가를 그리라고 요청한 뒤 페이지를 이동할 때에도 마찬지로 발생할 수 있음

### addPostFrameCallback

현재 프레임이 완성된 후 등록된 콜백을 실행시킨다.

```dart
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Counter>().increment();
      myCounter = context.read<Counter>().counter + 10;
    });

    // 이외의 방법들
    Future.delayed(const Duration(seconds: 0), () {
      context.read<Counter>().increment();
      myCounter = context.read<Counter>().counter + 10;
    });
    Future.microtask(() {
      context.read<Counter>().increment();
      myCounter = context.read<Counter>().counter + 10;
    });
```

## handle_dialog_page.dart

Theme.of()와 같은 InheritedWidget이 변경되면 dependent 위젯들도 rebuilt된다. dependent 위젯의 InheritedWidget레퍼런스가 constructor나 initState()에 있으면 변화를 반영하지 못한다.

다이얼로그는 다른 위젯위에 오버레이 되는 위젯인데 다른 위젯이 아직 생성이 완료가 되지 않은 상태에서 표시해달라고 요청할 수 없다는 의미이다.

```zsh
...
dependOnInheritedWidgetOfExactType<_LocalizationsScope>() or dependOnInheritedElement() was called before _HandleDialogPageState.initState() 
...
```

동일하게 addPostFrameCallback을 활용하여 해결한다.

```dart
  WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Be careful!'),
          );
        },
      );
    });
```

---

```zsh
setState() or markNeedsBuild() called during build.
```

```dart
  @override
  Widget build(BuildContext context) {
    if (context.read<Counter>().counter == 3) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Count is 3'),
            );
          },
        );
      });
    }
    ...
  }
```

## navigate_page.dart

```zsh
setState() or markNeedsBuild() called during build.
```

```dart
  @override
  Widget build(BuildContext context) {
    if (context.read<Counter>().counter == 3) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OtherPage(),
          ),
        );
      });
    }
    ...
  }
```

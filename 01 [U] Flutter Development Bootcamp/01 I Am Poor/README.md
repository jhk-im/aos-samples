# I Am Poor

## 학습내용

### void main() => runApp()

* 모든 플러터 앱의 시작점

### MaterialApp() Widget

* Material Design 을 사용하는 애플리케이션과 관련된 일반적인 위젯 포함
* AnimatedTheme, GridPaper 등과 같은 특정 기능을 추가하여 WidgetsApp 기반으로 구축
* home 속성이 null 인 경우 routes 테이블이 사용됨
* routes 테이블이 null 인 경우 onGenerateRoute 호출
* 마지막으로 onUnknownRoute 호출
* home, routes, onGenerateRoute, onUnknownRoute 가 모두 null 이고 builder 가 null 이 아닌 경우 Navigator 생성 안됨
* 자동으로 DefaultSelectionStyle 생성
* ThemeData.textSelectionTheme 색상이 null 인 경우
* DefaultSelectionStyle.selectionColor -> ColorScheme.primary / 0.4 opacity
  DefaultSelectionStyle.cursorColor -> ColorScheme.primary

### Scaffold() Widget

* 기본적인 Material Design 시각적 레이아웃 구조 구현
* Drawer, BottomSheet, FloatingActionButton 등의 API 제공
* 사용 가능한 공간을 채우기 위해 확장되며 일반적으로 전체 창이나 기기 화면을 채움
* 키보드가 보여지면 Scaffold 의 ancestor MediaQuery 위젯의 MediaQueryData.viewInsets 가 변경되고 재 빌드됨
* 기본적으로 body 가 키보드에 맞추어 크기가 조정됨
* resizeToAvoidBottomInset = false 인 경우 크기 조정 방지
* 어떠한 경우에도 포커스된 위젯이 스크롤 가능한 컨테이너 내에 있는 경우 스크롤됨
* MediaQueryData.padding 값은 iPhone X의 노치와 같이 완전히 표시되지 않을 수 있는 영역을 정의함
* appbar 또는 bottomNavigationBar 는 body 가 padding 을 피하도록 함
* SafeArea 위젯은 Scaffold 의 body 내에서 디스플레이 노치와 같은 영역을 피하는 데 사용

### AppBar() Widget

* ToolBar, TabBar, FlexibleSpaceBar 등의 위젯으로 구성됨
* 일반적으로 IconButton + PopupMenuButton 으로 표시되는 하나 이상의 공통 작업을 노출(overflow menu)
* 일반적으로 Scaffold.appBar 속성에 사용되어 화면 상단에 고정 높이로 배치됨
* CustomScrollView - SliverAppBar 를 사용하여 스크롤 가능한 앱바 구현
* 시스템 UI 침해를 피하기 위해 주변 MediaQuery 의 패딩을 기반으로 콘텐츠를 Inset
* 애니메이션 사용시 MediaQuery 위젯으로 감싸고 패딩을 조정하여 부드럽게 동작하도록 해야함
* Drawer 를 가진 Scaffold 내부에 있다면 Drawer 를 열기 위한 버튼이 추가됨
* Navigator 이전 route 가 있으면 BackButton 추가됨
* 위 동작들은 automaticallyImplyLeading = false 로 설정 off

### Image() Widget

* Image.new : ImageProvider 에서 이미지를 가져옴
* Image.asset : AssetBundle 에서 키를 사용하여 이미지를 가져옴
* Image.network : URL 에서 이미지를 가져옴
* Image.file : File 에서 이미지를 가져옴
* Image.memory : Unit8List 에서 이미지를 가져옴
* JPEG, PNG, GIF, Animated GIF, WebP, Animated WebP, BMP, WBMP
* paintImage 를 사용하여 그려짐

[paintImage](https://api.flutter.dev/flutter/painting/paintImage.html)

### Center()

* dimensions 가 제한되어 있고 widthFactor | heightFactor 가 Null 인 경우 가능한 큰 크기가 됨
* dimensions 가 제한되어 있지 않고 크기요소가 null 이면 child widget 의 크기와 일치
* 크기 요소가 Null 이 아닌 경우 child widget 과 크기 요소의 곱이 됨
* Align 은 child widget 위치를 커스텀 할 수 있음
* row 는 child widget 을 수평으로 표시
* column 은 child widget 을 수직으로 표시
* container 는 공통적인 페인팅, 위치 지정 및 크기 조정 위젯을 결합한 위젯

[Material Color System](https://m2.material.io/design/color/the-color-system.html#color-theme-creation)

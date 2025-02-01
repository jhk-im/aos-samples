# MiCard

## 학습내용

### Hot Reload and Hot Restart

* StatelessWidget을 통해 App을 다시 생성
* 내부 build 메서드에 의해 변경이 있을 때 마다 호출되어 reload 실행
* Hot Reload는 UI만 초기화 되고 데이터는 잃지 않음
* Hot Restart는 UI와 데이터도 초기화 됨

### StatelessWidget

* UI를 구체적으로 설명하는 위젯 모음을 빌드
* 빌드 프로세스는 재귀적으로 호출됨
* UI가 구체적으로 완전한 상태가 될 때 까지 유지됨
* 동적으로 변경될 수 있는 구성 요소의 경우 사용하는 것이 좋음
* build 메서드의 호출
  * 위젯이 트리에 처음 삽입될 때
  * 위젯의 부모가 구성을 변경할 때
  * InheritedWidget이 변경될 때
* 위젯 재구성시 성능유지
  * 복잡한 UI의 경우 Flutter에서 지원하는 방식을 찾아서 적용
  * 재사용 가능한 UI요소는 helper method 대신 위젯을 사용할 것
  * const 위젯인 경우 Flutter에서 대부분 재구성 작업을 생략함
  * IngeritedWidget의 사용으로 자주 재구성이 될 경우 변경되는 부분을 하위 항목으로 push하여 Stateless 위젯을 여러개의 위젯으로 리팩토링
  * Stateless -> StatefulWidget으로 리팩토링할 때 StatefulWidget의 GlobalKeys를 사용할 수 있음

### Container Widget

* 레이아웃 박스
* Single-child layout widgets
* 자식 위젯을 패딩이로 감싸고 추가적인 제약 조건을 적용
* 기본적으로 hitTest에 대해 false 반환
  * hitTest?
    * 지정된 크기의 직사각형에서 주어진 지점이 decoration을 맞추는지 여부를 테스트
* 컨테이너의 그리기 순서
  * 지정된 변환 적용
  * 패딩 영역 채우기 위해 decoration 그림
  * 자식 위젯을 그림
  * foregroundDecoration을 그려 패딩영역 채움
* 다른 위젯을 결합하여 사용하므로 동작이 복잡함
* 요약
  * 순서대로 정렬 고려
  * 자식 크기 고려
  * 너비, 높이, 제약조건 고려
  * 부모에 맞게 확장
  * 가능한 작이지려 시도
* 상세
  * 자식, 정렬, 높이, 너비, 제약조건이 없고 부모가 무제한 제약조건을 제공하는 경우 가능한 작게 크기를 맞추려 시도
  * 자식, 정렬이 없고 높이, 너비, 제약 조건이 제공되면 해당 제약 조건과 부모의 제약조건의 조하에 따라 가능한 작아지려 시도
  * 자식, 정렬, 높이, 너비, 제약 조건이 없고 부모가 제한된 제약 조건을 제공하면 부모에 맞게 확장됨
  * 정렬이 있고 부모가 무제한 제약 조건을 제공하면 자식 주변에 크기를 맞추려 시도
  * 정렬이 있고 부모가 제한된 제약 조건을 제공하면 부모에 맞게 확장 후 정렬에 따라 자식을 위치시킴
  * 자식이 있지만 정렬, 높이, 너비, 제약 조건이 없으면 부모에서 제공하는 제약 조건을 자식에게 전달 후 자식 크기에 맞게 조정함

```dart
child: Container(
    height: 100.0,
    width: 100.0,
    //margin: EdgeInsets.all(20.0),
    //margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
    //margin: EdgeInsets.fromLTRB(30.0, 10.0, 50.0, 20.0),
    margin: EdgeInsets.only(left: 30.0),
    padding: EdgeInsets.all(20.0),
    color: Colors.white,
    child: Text('Hello'),
),
```

### Column, Row Widget

* Column
  * 수직으로 자식 위젯을 표시
  
* Row
  * 수평으로 자식 위젯을 표시

* 공통
  * Multi-child layout widget
  * 스크롤 x
  * 사용 가능한 공간을 채우기 위해 ExpandedWidget으로 자식 위젯을 감싸야 함

```dart
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100.0,
                height: double.infinity,
                color: Colors.red,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.yellow,
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.green,
                  )
                ],
              ),
              Container(
                width: 100.0,
                height: double.infinity,
                color: Colors.blue,
              ),
            ],
          ),
```

### CircleAvatar Widget

* 사용자의 프로필 이미지를 원형으로 표시
* 이미지가 없는 경우 이니셜 표시
* radius로 크기 조절

### Custom Font

[Google Fonts](https://fonts.google.com/)

[Flutter Custom Font](https://docs.flutter.dev/cookbook/design/fonts)

* 글꼴 추가는 Hot Reload, Restart 적용 안됨

### Icon Widget

* Material에 미리 정의 된 IconDatas와 같은 IconData에서 설명된 글리프로 그려진 그래픽 아이콘 위젯
* 상호작용 불가능 -> 상호작용은 IconButton 활용
* 주위에 Directionnality 위젯이 있어야 함 -> 이란적으로 WidgetsApp 또는 MaterialApp에 자동으로 추가됨
* 렌더링 된 아이콘이 squared형임을 가정함

[Flutter Icons](https://api.flutter.dev/flutter/material/Icons-class.html)

[Material Icons](https://m3.material.io/styles/icons/overview)

[Material Palette](https://www.materialpalette.com/)

```dart
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/jhk.jpg'),
              ),
              Text(
                'JeongHun kim',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: Colors.teal.shade100,
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.teal,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '+82 010 1234 5678',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        color: Colors.teal.shade900,
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.teal,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'jhk@jhk.com',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        color: Colors.teal.shade900,
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
```

### Card Widget

* 둥근 모서리와 그림자가 있는 패널
* 앨범, 연락처와 같은 저오를 나타내는 데 사용되는 Material Sheet
* padding 속성이 없음
* Padding Class
  * 주어진 패딩으로 자식 위젯을 안쪽으로 감싸는 위젯
  * 주어진 패딩 값만큼 제약 조건을 충족시켜 자식 위젯이 더 작은 크기에서 레이아웃 되도록 함
  * 패딩을 고려한 크기로 자식 위젯을 확장하여 주어진 패딩 값 만큼 빈 공간 생성
* ListTitle Class
  * 텍스트와 선행/후행 아이콘을 포함하는 고정 높이 패널
  * 아이콘은 leading/trailing이 매개변수로 정의
  * 첫 번째 텍스트 줄은 title
  * subtitle값은 선택적이며 하나의 추가 텍스트 혹은 isThreeLine=true로 설정하여 두 줄의 공간을 사용할 수 있음
  * 아이콘의 높이는 Material 규격에 따라 제한됨
  * 일반적으로 ListView, Drawer, Card에서 Column 배열됨
  * 페인트를 위해 트리에 Material 위젯 상위계층이 필요함 -> 일반적으로 Scaffold에 의해 제공됨 -> titleColor, selectedTitleColor, focusColor 및 hoverColor는 ListTitle 자체에서 그려지지 않고 상위 층에 의해 그려짐

### Divider Widget

* 얇은 수평선이며 양쪽에 패딩이 있음
* 구분선으로 사용
* list, Drawer 분리에 사용
* ListTitle 아이템 내부에 구분선은 ListTitle.divideTitles를 활용

```dart
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/jhk.jpg'),
              ),
              Text(
                'JeongHun kim',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: Colors.teal.shade100,
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.teal,
                  ),
                  title: Text(
                    '+82 000 1234 5678',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'jhk@email.com',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                ),
              )
            ],
          )
```

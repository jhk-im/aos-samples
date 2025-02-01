# Bitcon Ticker

## 학습내용

### Dropdown Widget

* value : 현재 선택된 항목의 값
* items : 드롭다운 목록에서 선택 가능한 항목의 리스트
* onChanged : 항목이 변경될 때 호출되는 함수
* hint : 드롭다운이 선택되기 전에 나타나는 힌트 텍스트

```dart
String dropdownValue = 'One';

DropdownButton<String>(
  value: dropdownValue,
  icon: Icon(Icons.arrow_downward),
  onChanged: (String newValue) {
    setState(() {
      dropdownValue = newValue;
    });
  },
  items: <String>['One', 'Two', 'Three', 'Four']
    .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
)
```

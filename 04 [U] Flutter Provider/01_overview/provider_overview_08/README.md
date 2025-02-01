# provider_overview_06=8

## Consumer

* Provider`<`T`>`통해서 타입 T의 오브젝트를 얻을 필요가 없다.
* 새로운 위젯에서 Provider.of를 실행하고 위젯의 build구현을 builder에 위임한다.
* builder는 Not Null이어야 하고 값이 변할 때 마다 builder가 호출되어야 한다.

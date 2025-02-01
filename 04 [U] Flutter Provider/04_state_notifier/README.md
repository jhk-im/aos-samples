# StateNotifier + StateNotifierProvider

## StateNotifierProvider
 
- provider 저자 Remi의 패키지
- ProxyProvider를 사용하지 않아도 됨
- Riverpod에서 사용되므로 향후 Riverpod사용시 이해하는데 도움됨
 
## State pattern
 
- Createing state class
  - class TodoListState {}
- Createing ChangeNotifier and initializing state
  - class TodoList with ChangeNotifiere { TodoListState(todos: []); } 

- Changing state and notifying that change to the listeners
  - state = state.copyWith(...);
  - notifyListeners();

- Provider를 사용하다보면
  - state 변수가 주어졌으면..
  - 관리하는 State의 타입을 알수있으면..
  - state가 protected 된다면..
  - StateNotifier / StateNotifierProvider로 구현가능

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/todo_model.dart';
import 'providers.dart';

/// Todo 아이템 숫자
/// 생성, 삭제, Complete 변경에 영향을 받으므로 상태관리
class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;
  const ActiveTodoCountState({
    required this.activeTodoCount,
  });

  factory ActiveTodoCountState.initial() {
    return const ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  List<Object> get props => [activeTodoCount];

  @override
  bool get stringify => true;

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}

class ActiveTodoCount with ChangeNotifier {
  // ActiveTodoCountState _state = ActiveTodoCountState.initial();
  late ActiveTodoCountState _state;
  final int initialActiveTodoCount;

  /// 정확한 initial state 구현
  ActiveTodoCount({
    required this.initialActiveTodoCount,
  }) {
    print('initialActiveTodoCount: $initialActiveTodoCount');
    _state = ActiveTodoCountState(activeTodoCount: initialActiveTodoCount);
  }
  ActiveTodoCountState get state => _state;

  /// ProxyProvider를 통해 TodoList를 입력받음
  /// 의존하는 값을 추가할때, 업데이트할때
  void update(TodoList todoList) {
    print(todoList.state);
    final int newActiveTodoCount = todoList.state.todos
        .where((Todo todo) => !todo.completed)
        .toList()
        .length;

    _state = _state.copyWith(activeTodoCount: newActiveTodoCount);
    print(state);
    notifyListeners();
  }
}

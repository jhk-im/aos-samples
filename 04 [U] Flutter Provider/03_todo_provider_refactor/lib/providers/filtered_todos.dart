import 'package:equatable/equatable.dart';

import '../models/todo_model.dart';
import 'providers.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filterdTodos;
  const FilteredTodosState({
    required this.filterdTodos,
  });

  factory FilteredTodosState.initial() {
    return const FilteredTodosState(filterdTodos: []);
  }

  @override
  List<Object> get props => [filterdTodos];

  @override
  bool get stringify => true;

  FilteredTodosState copyWith({
    List<Todo>? filterdTodos,
  }) {
    return FilteredTodosState(
      filterdTodos: filterdTodos ?? this.filterdTodos,
    );
  }
}

/// ChangeNotifier제거
/// 생성자를 통해 [TodoFilter], [TodoSearch], [TodoList] 전달받음
/// 전달받은 오브젝트는 ChangeNotifier mixin 되어있음
class FilteredTodos {
  final TodoFilter todoFilter;
  final TodoSearch todoSearch;
  final TodoList todoList;
  FilteredTodos({
    required this.todoFilter,
    required this.todoSearch,
    required this.todoList,
  });

  FilteredTodosState get state {
    // ignore: no_leading_underscores_for_local_identifiers
    List<Todo> _filteredTodos;

    switch (todoFilter.state.filter) {
      case Filter.active:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoList.state.todos;
        break;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearch.state.searchTerm.toLowerCase()))
          .toList();
    }

    return FilteredTodosState(filterdTodos: _filteredTodos);
  }
}

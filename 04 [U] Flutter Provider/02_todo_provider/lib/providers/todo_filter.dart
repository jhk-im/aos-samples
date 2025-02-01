import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/todo_model.dart';

/// 현재 필터상태 변경 하고 필터에 리스너가있는 위젯에게 알림
/// Enum으로 만들어도 되지만 클래스로 생성하면 Type Coercion을 피할 수 있고 Equatable 패키지도 활용할 수 있음
/// Type Coercion : 하나의 데이터 타입을 다른 데이터 타입으로 자동 변환하는 것을 의미함
class TodoFilterState extends Equatable {
  final Filter filter;
  const TodoFilterState({
    required this.filter,
  });

  /// factory contstructor을 활용하면 initial state가 무엇인지 시간이 지나도 금방 식별이 가능하다는 장점이 있음
  factory TodoFilterState.initial() {
    return const TodoFilterState(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}

/// 리스너가 있는 위젯에 알림
class TodoFilter with ChangeNotifier {
  TodoFilterState _state = TodoFilterState.initial();
  TodoFilterState get state => _state;

  /// 상태 변경 함수
  /// all, active, create에서 트리거됨
  void changeFilter(Filter newFilter) {
    /// copyWith와 mutation은 객체지향 프로그래밍에서 자주 사용되는 개념입니다. 특히 copyWith는 불변 객체(immutable object)를 다룰 때 유용하며, mutation은 객체의 상태를 변경하는 것을 의미합니다.
    _state = _state.copyWith(filter: newFilter);
    notifyListeners();
  }
}

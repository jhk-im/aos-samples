import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// 사용자가 입력한 검색어는 TodoList UI에 영향을 미친다.
/// 사용자의 입력상태를 관리한다.
class TodoSearchState extends Equatable {
  final String searchTerm;
  const TodoSearchState({
    required this.searchTerm,
  });

  factory TodoSearchState.initial() {
    /// 예측이 가능한 코드
    /// 타입 충돌 방지
    return const TodoSearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

/// 리스너에게 알려줄 클래스
class TodoSearch with ChangeNotifier {
  TodoSearchState _state = TodoSearchState.initial();
  TodoSearchState get state => _state;

  /// 사용자 입력상태 변경 함수
  void setSearchTerm(String newSearchTerm) {
    _state = _state.copyWith(searchTerm: newSearchTerm);
    notifyListeners();
  }
}

import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

class TodoSearchState extends Equatable {
  final String searchTerm;
  const TodoSearchState({
    required this.searchTerm,
  });

  factory TodoSearchState.initial() {
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

/// StateNotifier 적용
class TodoSearch extends StateNotifier<TodoSearchState> {
  TodoSearch() : super(TodoSearchState.initial());

  void setSearchTerm(String newSearchTerm) {
    state = state.copyWith(searchTerm: newSearchTerm);
  }
}

// class TodoSearch with ChangeNotifier {
//   TodoSearchState _state = TodoSearchState.initial();
//   TodoSearchState get state => _state;

//   void setSearchTerm(String newSearchTerm) {
//     _state = _state.copyWith(searchTerm: newSearchTerm);
//     notifyListeners();
//   }
// }

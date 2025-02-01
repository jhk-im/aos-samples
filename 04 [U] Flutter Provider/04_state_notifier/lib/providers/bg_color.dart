import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

class BgColorState extends Equatable {
  final Color color;

  const BgColorState({
    required this.color,
  });

  @override
  List<Object> get props => [color];

  @override
  bool get stringify => true;

  BgColorState copyWith({
    Color? color,
  }) {
    return BgColorState(
      color: color ?? this.color,
    );
  }
}

/// StateNotifier<T> 타입을 표시한다는 점이 ChangeNotifier와 가장 큰 차이점
class BgColor extends StateNotifier<BgColorState> {
  BgColor() : super(const BgColorState(color: Colors.blue));

  /// Floating action button event
  /// state 변수를 정의하지 않고도 사용 가능, 값을 넣을수도 있음
  /// notifierListener를 호출하지 않음
  void changeColor() {
     if (state.color == Colors.blue) {
      state = state.copyWith(color: Colors.black);
    } else if (state.color == Colors.black) {
      state = state.copyWith(color: Colors.red);
    } else {
      state = state.copyWith(color: Colors.blue);
    }
  }
}

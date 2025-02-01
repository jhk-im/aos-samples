import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

import 'bg_color.dart';

class CounterState extends Equatable {
  final int counter;
  const CounterState({
    required this.counter,
  });

  @override
  List<Object> get props => [counter];

  @override
  bool get stringify => true;

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}

/// LocatorMixin은 watch, read등을 활용하여 위젯트리상에 특정 provider를 찾아줌
class Counter extends StateNotifier<CounterState> with LocatorMixin {
  Counter() : super(const CounterState(counter: 0));

  /// counter 증가
  /// watch 함수는 update override함수 내에서만 사용 가능
  void increment() {
    print(read<BgColor>().state);

    Color currentColor = read<BgColor>().state.color;

    if (currentColor == Colors.black) {
      state = state.copyWith(counter: state.counter + 10);
    } else if (currentColor == Colors.red) {
      state = state.copyWith(counter: state.counter - 10);
    } else {
      state = state.copyWith(counter: state.counter + 1);
    }
  }

  /// 다른 오브젝트의 업데이트를 리스닝해줌
  /// update 내에선 read함수를 사용할 수 없음
  @override
  void update(Locator watch) {
    print('in Counter StateNotifier: ${watch<BgColorState>().color}');
    print('in Counter StateNotifier: ${watch<BgColor>().state.color}');
    super.update(watch);
  }
}

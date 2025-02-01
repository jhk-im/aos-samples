import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// 유니크 아이디 생성
Uuid uuid = const Uuid();

/// Equatable props, stringify
class Todo extends Equatable {
  final String id;

  /// 유니크 아이디
  final String desc;

  /// 내용
  final bool completed;

  /// 완료여부
  Todo({
    String? id,

    /// 생성시 uuid, 편집시 기존 아이디
    required this.desc,
    this.completed = false,

    /// 생성시 false
  }) : id = id ?? uuid.v4();

  @override
  List<Object> get props => [id, desc, completed];

  @override
  bool get stringify => true;
}

enum Filter {
  all,
  active,
  completed,
}

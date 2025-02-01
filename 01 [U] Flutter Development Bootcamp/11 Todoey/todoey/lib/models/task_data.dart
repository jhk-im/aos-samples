import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todoey/models/task.dart';

class TaskData extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(name: "sample"),
  ];

  int get taskCount {
    return _tasks.length;
  }

  UnmodifiableListView<Task>? get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addTask(String taskText) {
    final task = Task(name: taskText);
    _tasks.add(task);
    notifyListeners();
  }

  void isToggle(Task? task) {
    task?.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task? task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
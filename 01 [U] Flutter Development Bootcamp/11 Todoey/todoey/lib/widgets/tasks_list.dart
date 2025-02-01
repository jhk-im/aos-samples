import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/widgets/tasks_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
        builder: (BuildContext context, taskData, Widget? child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final task =  taskData.tasks?[index];
              return TasksTile(
                taskTitle: task?.name ?? "",
                isChecked: task?.isDone ?? false,
                checkboxCallback: (bool isToggle) {
                  taskData.isToggle(task);
                },
                longPressCallback: () {
                  taskData.deleteTask(task);
                },
              );
            },
            itemCount: taskData.taskCount,
          );
        },
    );
  }
}
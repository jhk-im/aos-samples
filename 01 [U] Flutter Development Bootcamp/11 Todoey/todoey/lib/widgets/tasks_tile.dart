import 'package:flutter/material.dart';

class TasksTile extends StatelessWidget {
  final String taskTitle;
  final bool isChecked;
  final Function checkboxCallback;
  final Function longPressCallback;

  const TasksTile({
    super.key, required this.taskTitle,
    required this.isChecked,
    required this.checkboxCallback,
    required this.longPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        longPressCallback();
      },
      title: Text(taskTitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
      activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: (bool? isToggle) {
          checkboxCallback(isToggle ?? false);
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../data/task_type.dart';

class TaskTypeListItem extends StatelessWidget {
  TaskTypeListItem({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectedIndex,
  });

  TaskType taskType;
  int index;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: index == selectedIndex
          ? BoxDecoration(
              border: Border.all(color: Color(0xff18DAA3), width: 2),
              borderRadius: BorderRadius.circular(12),
            )
          : BoxDecoration(),
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(taskType.image),
          ),
          Text(taskType.title),
        ],
      ),
    );
  }
}

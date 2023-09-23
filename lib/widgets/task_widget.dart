import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:note_app/screens/edit_task_screen.dart';

import '../data/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});

  Task task;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isDone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.isDone = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return _getTaskItem();
  }

  Widget _getTaskItem() {
    return GestureDetector(
      onTap: () {
        isTapped();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: EdgeInsets.all(12),
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _getTitle(),
                  Text(
                    widget.task.subTitle,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  _getTimeEditButtons(widget.task),
                ],
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Image.asset(widget.task.taskType.image),
          ],
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MSHCheckbox(
          size: 30,
          value: isDone,
          colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
            checkedColor: Color(0xff18DAA3),
          ),
          style: MSHCheckboxStyle.fillScaleCheck,
          onChanged: (isTrue) {
            isTapped();
          },
        ),
        Text(
          widget.task.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _getTimeEditButtons(Task task) {
    return Row(
      children: [
        Container(
          width: 90,
          height: 30,
          decoration: BoxDecoration(
            color: Color(0xff18DAA3),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: Row(
              children: [
                Text(
                  '${task.time.hour.toString().padLeft(2, '0')}:${task.time.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'images/icon_time.png',
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(task: widget.task),
              ),
            );
          },
          child: Container(
            width: 95,
            height: 30,
            decoration: BoxDecoration(
              color: Color(0xffE2F6F1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ویرایش',
                    style: TextStyle(
                      color: Color(0xff18DAA3),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    'images/icon_edit.png',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void isTapped() {
    widget.task.isDone = !isDone;
    widget.task.save();
    setState(() {
      isDone = !isDone;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _controllerTaskTitle = TextEditingController();
  final TextEditingController _controllerTaskSubtitle = TextEditingController();

  final taskBox = Hive.box<Task>('taskBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44, vertical: 40),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: _controllerTaskTitle,
                    decoration: InputDecoration(
                      label: Text(
                        'عنوان تسک',
                      ),
                      labelStyle: TextStyle(
                        color: Colors.green[300],
                        fontSize: 20,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xffe1f5da),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xff18DAA3),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: _controllerTaskSubtitle,
                    maxLines: 2,
                    decoration: InputDecoration(
                      label: Text(
                        'توضیحات تسک',
                      ),
                      labelStyle: TextStyle(
                        color: Colors.green[300],
                        fontSize: 20,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xffe1f5da),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xff18DAA3),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ElevatedButton(
                  onPressed: () {
                    String taskTitle = _controllerTaskTitle.text;
                    String taskSubtitle = _controllerTaskSubtitle.text;
                    addTask(taskTitle, taskSubtitle);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff18DAA3),
                    minimumSize: Size(220, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'اضافه کردن تسک',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask(String taskTitle, String taskSubtitle) {
    if (taskTitle == '' || taskSubtitle == '') return;

    var task = Task(title: taskTitle, subTitle: taskSubtitle);
    taskBox.add(task);
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:note_app/util/utility.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';
import '../widgets/task_type_item.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _controllerTaskTitle = TextEditingController();
  final TextEditingController _controllerTaskSubtitle = TextEditingController();

  final taskBox = Hive.box<Task>('taskBox');
  DateTime? _time;

  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _time = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44, vertical: 20),
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
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomHourPicker(
                  title: 'زمان تسک را انتخاب کن',
                  negativeButtonText: 'حذف کن',
                  positiveButtonText: 'انتخاب کن',
                  titleStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff18DAA3),
                  ),
                  elevation: 5,
                  positiveButtonStyle: TextStyle(
                    color: Color(0xff18DAA3),
                  ),
                  onPositivePressed: (context, time) {
                    _time = time;
                  },
                ),
              ),
              Container(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getTaskTypeList().length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: TaskTypeListItem(
                        taskType: getTaskTypeList()[index],
                        index: index,
                        selectedIndex: _selectedIndex,
                      ),
                    );
                  },
                ),
              ),
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

    var task = Task(
      title: taskTitle,
      subTitle: taskSubtitle,
      time: _time!,
      taskType: getTaskTypeList()[_selectedIndex],
    );
    taskBox.add(task);
    Navigator.pop(context);
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';
import '../widgets/task_type_item.dart';
import '../util/utility.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});

  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _controllerTaskTitle = TextEditingController();
  final TextEditingController _controllerTaskSubtitle = TextEditingController();

  final taskBox = Hive.box<Task>('taskBox');
  DateTime? _time;

  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerTaskTitle.text = widget.task.title;
    _controllerTaskSubtitle.text = widget.task.subTitle;
    _time = widget.task.time;
    _selectedIndex = getTaskTypeList().indexWhere(
      (element) {
        return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
      },
    );
    print(_selectedIndex);
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
                  date: _time,
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
                    editTask(taskTitle, taskSubtitle);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff18DAA3),
                    minimumSize: Size(220, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'ویرایش تسک',
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

  void editTask(String taskTitle, String taskSubtitle) {
    if (taskTitle == '' || taskSubtitle == '') return;
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubtitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedIndex];
    widget.task.save();
  }
}

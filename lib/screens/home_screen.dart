import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:note_app/screens/add_task_screen.dart';
import 'package:note_app/task.dart';
import 'package:note_app/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>('taskBox');
  bool isFabVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: (context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (notification.direction == ScrollDirection.forward) {
                    setState(() {
                      isFabVisible = true;
                    });
                  }
                  if (notification.direction == ScrollDirection.reverse) {
                    setState(() {
                      isFabVisible = false;
                    });
                  }
                  return true;
                },
                child: ListView.builder(
                  itemCount: taskBox.values.length,
                  itemBuilder: (context, index) {
                    Task task = taskBox.values.toList()[index];
                    return _getListItem(task);
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
          },
          backgroundColor: Color(0xff18DAA3),
          child: Image.asset('images/icon_add.png'),
        ),
      ),
    );
  }

  Widget _getListItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        task.delete();
      },
      child: TaskWidget(task: task),
    );
  }
}

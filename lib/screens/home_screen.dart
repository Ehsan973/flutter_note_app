import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: taskBox.values.length,
                  itemBuilder: (context, index) {
                    Task task = taskBox.values.toList()[index];
                    return TaskWidget(task: task);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

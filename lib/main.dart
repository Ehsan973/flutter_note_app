import 'package:flutter/material.dart';
import 'package:note_app/hive_exercises/car.dart';
import 'package:note_app/hive_exercises/hive_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/screens/add_task_screen.dart';
import 'package:note_app/screens/home_screen.dart';
import 'hive_exercises/student.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('names');

  Hive.registerAdapter(CarAdapter());
  await Hive.openBox<Car>('carBox');

  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('studentBox');
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SM',
      ),
      debugShowCheckedModeBanner: false,
      home: AddTaskScreen(),
    );
  }
}

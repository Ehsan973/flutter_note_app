import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'student.dart';

import './car.dart';

class HiveScreen extends StatefulWidget {
  const HiveScreen({super.key});

  @override
  State<HiveScreen> createState() => _HiveScreenState();
}

class _HiveScreenState extends State<HiveScreen> {
  String inputText = '';
  var controller = TextEditingController();

  var box = Hive.box('names');
  var carBox = Hive.box<Car>('carBox');
  var studentBox = Hive.box<Student>('studentBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                color: Colors.amber,
                width: 200,
                height: 100,
                child: Center(
                  child: Text(
                    inputText,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    inputText = controller.text;
                  });
                },
                child: Text('Read from textfield'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      box.put(1, controller.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Text('Create/Update'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          try {
                            inputText = box.get(1);
                          } catch (e) {
                            inputText = 'null';
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text('Read'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        box.delete(1);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Text('Delete'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        carBox.put(
                          1,
                          Car(
                            name: controller.text,
                            topSpeed: 300,
                            price: 1000,
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    child: Text('Write Car'),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        inputText = carBox.get(1)!.name;
                        inputText += '\n${carBox.get(1)!.topSpeed} km/h';
                        inputText += '\n${carBox.get(1)!.price}\$';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    child: Text('Read Car'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      var params = controller.text.split(' ');
                      setState(() {
                        studentBox.put(
                          1,
                          Student(
                            name: params[0],
                            family: params[1],
                            grade: double.parse(params[2]),
                            age: 32,
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Write Student'),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        inputText =
                            "${studentBox.get(1)!.name} ${studentBox.get(1)!.family} ";
                        inputText += '\n${studentBox.get(1)!.grade}';
                        inputText += '   ${studentBox.get(1)!.age} years old';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Read Student'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: Center(
          child: _getTaskItem(),
        ),
      ),
    );
  }

  Widget _getTaskItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
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
                  'تمرین زبان انگلیسی کتاب آموزشگاه',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                _getTimeEditButtons(),
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Image.asset('images/workout.png'),
        ],
      ),
    );
  }

  Widget _getTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MSHCheckbox(
          size: 30,
          value: isChecked,
          colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
            checkedColor: Color(0xff18DAA3),
          ),
          style: MSHCheckboxStyle.fillScaleCheck,
          onChanged: (isTrue) {
            setState(() {
              isChecked = isTrue;
            });
          },
        ),
        Text(
          'تمرین زبان انگلیسی',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _getTimeEditButtons() {
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
                  '10:00',
                  style: TextStyle(
                    color: Colors.white,
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
        Container(
          width: 95,
          height: 30,
          decoration: BoxDecoration(
            color: Color(0xffE2F6F1),
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
      ],
    );
  }
}

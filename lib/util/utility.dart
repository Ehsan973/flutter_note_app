import 'package:note_app/data/type_enum.dart';

import '../data/task_type.dart';

List<TaskType> getTaskTypeList() {
  return [
    TaskType(
        image: 'images/meditate.png',
        title: 'تمرکز',
        taskTypeEnum: TaskTypeEnum.focus),
    TaskType(
        image: 'images/social_frends.png',
        title: 'میتینگ',
        taskTypeEnum: TaskTypeEnum.date),
    TaskType(
        image: 'images/hard_working.png',
        title: 'کار زیاد',
        taskTypeEnum: TaskTypeEnum.working),
  ];
}

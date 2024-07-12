import 'dart:ui';

List<Color> priorityColor = const [
  Color(0xffFACBBA),
  Color(0xffD7F0FF),
  Color(0xffFAD9FF),
];

class TaskModel {

  final String title;
  final String desc;
  final String sTime;
  final String eTime;
  final int priority;
  final bool getAlert;
  final DateTime dateTime;
  final bool activeBtn;

  TaskModel({
    required this.title,
    required this.desc,
    required this.sTime,
    required this.eTime,
    required this.priority,
    required this.getAlert,
    required this.dateTime,
    required this.activeBtn,
  });
}

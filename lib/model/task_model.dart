import 'dart:ui';

Map<Priority, Color> priorityColor = const {
  Priority.high: Color(0xffFACBBA),
  Priority.medium: Color(0xffD7F0FF),
  Priority.low: Color(0xffFAD9FF),
};

enum Priority { high, medium, low }

class TaskModel {
  final String title;
  final String desc;
  final String sTime;
  final String eTime;
  final Priority priority;
  final bool getAlert;
  final DateTime dateTime;
  bool activeBtn;

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

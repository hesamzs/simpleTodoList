import 'package:flutter/material.dart';

import '../model/task_model.dart';
import '../widgets/color_widget.dart';
import '../widgets/date_widget.dart';
import '../widgets/text_widget.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarWidget("Create new task", context),
                const SizedBox(height: 20),
                const TableCalendar(),
                const SizedBox(height: 20),
                customTitle("Schedule"),
                customTextField("Title", false),
                const SizedBox(
                  height: 15,
                ),
                customTextField("Description", true),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SelectTime(title: "Start Time"),
                    Spacer(),
                    SelectTime(title: "End Time"),
                  ],
                ),
                customTitle("Priority"),
                priorityRow(),
                const SizedBox(height: 20),

                const AlertNotification(),
                const SizedBox(height: 20),

                customBtn(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonCheckBox extends StatefulWidget {
  final String title;
  final Function(bool) onTap;
  final Color borderColor;

  const ButtonCheckBox({Key? key, required this.title, required this.onTap, required this.borderColor}) : super(key: key);

  @override
  State<ButtonCheckBox> createState() => _ButtonCheckBoxState();
}

class _ButtonCheckBoxState extends State<ButtonCheckBox> {
  bool _checked = false; // default value is false
  late Color _borderColor;

  @override
  void initState() {
    super.initState();
    _borderColor = widget.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          _checked = !_checked;
        });
        widget.onTap(_checked);
      },
      child: Container(
        width: sWidth / 3.7,
        height: sWidth / 8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color:  _borderColor,
            width: 2,
          ),
          color: _checked ? _borderColor : null,
        ),
        child: cText(
          widget.title,"Roboto",
          fontSize: 18,
          color: _checked ? grayColor:white
        ),
      ),
    );
  }
}

Widget priorityRow() {
  return Row(
    children: [
      const Spacer(),
      ButtonCheckBox(
        borderColor: priorityColor[Priority.high]!,
        title: "High",
        onTap: (p0) => {},
      ),
      const Spacer(),
      ButtonCheckBox(
        borderColor: priorityColor[Priority.medium]!,
        title: "Middle",
        onTap: (p0) => {},
      ),
      const Spacer(),
      ButtonCheckBox(
        borderColor: priorityColor[Priority.low]!,
        title: "low",
        onTap: (p0) => {},
      ),
      const Spacer()
    ],
  );
}

Widget customTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        cText(
          title,
          "Roboto",
          fontSize: 22,
          fontWeight: FontWeight.w300,
        ),
        const Spacer(),
      ],
    ),
  );
}

Widget customBtn() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Color(0xffBA83DE), Color(0xffDE83B0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: cText("Custom Button", "Roboto", fontSize: 16),
    ),
  );
}

class AlertNotification extends StatefulWidget {
  const AlertNotification({
    Key? key,
  }) : super(key: key);

  @override
  State<AlertNotification> createState() => _AlertNotificationState();
}

class _AlertNotificationState extends State<AlertNotification> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          cText("Get alert for this task", "Roboto", color: white),
          const Spacer(),
          SizedBox(
            child: Switch(
              value: isChecked,
              onChanged: (checked) {
                setState(() {
                  isChecked = !isChecked;
                });
              },
              activeTrackColor: const Color(0xffA378FF),
              thumbColor: MaterialStateProperty.resolveWith((Set states) {
                return white;
              }),
              inactiveTrackColor: grayColor,
              splashRadius: 20.0, // Fix: set a valid double value
            ),
          )
        ],
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  final String title;

  const SelectTime({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  late TimeOfDay _timeOfDay;

  @override
  void initState() {
    super.initState();
    _timeOfDay = const TimeOfDay(hour: 0, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        cText(
          widget.title,
          "Roboto",
          color: white,
          fontSize: 22,
          fontWeight: FontWeight.w300,
        ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: _timeOfDay,
              confirmText: "Ok",
              cancelText: "Cancel",
            );
            if (pickedTime != null && pickedTime != _timeOfDay) {
              setState(() {
                _timeOfDay = pickedTime;
              });
            }
          },
          child: Container(
            height: 50,
            width: sWidth / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: grayColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 22,
                  color: textPurple,
                ),
                const SizedBox(
                  width: 10,
                ),
                cText(
                  GetDate().formatTimeOfDay(_timeOfDay),
                  "Roboto",
                  color: white,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget appBarWidget(String text, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.arrow_back_outlined,
                color: white,
                size: 16,
              ),
            ),
          ),
        ),
        const Spacer(),
        cText(
          text,
          "Roboto",
          fontSize: 23,
          fontWeight: FontWeight.w400,
        ),
        const Spacer(),
      ],
    ),
  );
}

Widget customTextField(String hint, bool isMulti) {
  return Container(
    padding: const EdgeInsets.only(top: 0),
    decoration: BoxDecoration(color: grayColor, borderRadius: BorderRadius.circular(8)),
    child: TextField(
      maxLines: isMulti ? null : 1,
      minLines: isMulti ? 3 : 1,
      maxLength: isMulti ? 500 : null,
      cursorColor: white,
      style: const TextStyle(color: white, fontSize: 16),
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        hintText: hint,
        fillColor: white,
        hintStyle: const TextStyle(color: white, fontSize: 16),
        counterStyle: const TextStyle(color: white),
      ),
    ),
  );
}

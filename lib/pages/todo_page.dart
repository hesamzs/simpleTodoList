import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simpletodolist/widgets/color_widget.dart';
import 'package:simpletodolist/widgets/date_widget.dart';
import 'package:simpletodolist/widgets/text_widget.dart';

import '../model/task_model.dart';
import '../widgets/progress_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<TaskModel> todayTasks = [
    TaskModel(
      title: "Title",
      desc: "Desc",
      sTime: "1",
      eTime: "2",
      priority: 1,
      getAlert: true,
      dateTime: DateTime.now(),
      activeBtn: false,
    ),
    TaskModel(
      title: "Title1",
      desc: "Desc1",
      sTime: "1",
      eTime: "2",
      priority: 0,
      getAlert: true,
      dateTime: DateTime.now(),
      activeBtn: true,
    ),
  ];

  double progressSize = 0.6;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                headerWidget(),
                searchWidget(),
                seeAllWidget("Progress"),
                progressWidget(progressSize),
                seeAllWidget("Today’s Task"),
                taskListBuilder(todayTasks),
                seeAllWidget("Tomorrow Task"),
                taskListBuilder(todayTasks),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget headerWidget() {
  return Row(
    children: [
      cText(
        "You have got 5 task\ntoday to complete",
        "Roboto",
        fontSize: 24,
      ),
      const Spacer(),
      Stack(
        children: [
          Image.asset(
            "assets/images/prof.png",
            width: 50,
            height: 50,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFF763B),
              ),
              width: 15,
              height: 15,
              child: Center(
                child: cText(
                  "5",
                  "Inter",
                  fontSize: 9,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget searchWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Container(
      height: 44,
      decoration: BoxDecoration(
        color: grayColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SvgPicture.asset("assets/svg/search_icon.svg"),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 4),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Search Task Here",
                  hintStyle: TextStyle(
                    color: white,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget seeAllWidget(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        cText(
          text,
          "Roboto",
          fontSize: 22,
          fontWeight: FontWeight.w300,
        ),
        const Spacer(),
        cText(
          "See All",
          "Roboto",
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPurple,
        ),
      ],
    ),
  );
}

Widget taskListBuilder(List<TaskModel> list) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
      TaskModel item = list[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: grayColor,
          ),
          child: Row(
            children: [
              Container(
                width: 15,
                decoration: BoxDecoration(
                  color: priorityColor[item.priority],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cText(
                        item.title,
                        "Inter",
                        fontSize: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/svg/calendar.svg"),
                            const SizedBox(width: 10),
                            cText(
                              "${item.dateTime.day} ${GetDate().getMonth(item.dateTime.month)}",
                              "Inter",
                              color: lightWhite,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Checkbox(
                  value: item.activeBtn,
                  onChanged: (bool? value) {},
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget progressWidget(double progressSize) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: darkGrayColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 10),
          child: cText("Daily Task", "Inter"),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: cText(
            "2/3 Task Completed",
            "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: lightWhite,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cText("You are almost done go ahead", "Inter", fontSize: 14, fontWeight: FontWeight.w200),
            cText(
              "${progressSize * 100}%",
              "Inter",
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0, top: 5),
          child: CustomProgressIndicator(
            textPurple,
            progressSize,
          ),
        ),
      ],
    ),
  );
}

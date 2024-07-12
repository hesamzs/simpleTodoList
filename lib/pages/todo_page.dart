import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simpletodolist/widgets/color_widget.dart';
import 'package:simpletodolist/widgets/text_widget.dart';

import '../widgets/progress_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
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
                Container(
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
                          cText("You are almost done go ahead", "Inter", fontSize: 14, fontWeight: FontWeight.w100),
                          cText(
                            "60%",
                            "Inter",
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0, top: 5),
                        child: GradientProgressIndicator(
                          textPurple,
                          0.9,
                        ),
                      ),
                    ],
                  ),
                ),
                seeAllWidget("Today’s Task"),
                seeAllWidget("Tommorrow Task"),
                // const Spacer(),
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

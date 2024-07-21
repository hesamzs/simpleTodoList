import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpletodolist/widgets/color_widget.dart';
import 'package:simpletodolist/widgets/text_widget.dart';

class GetDate {
  final now = DateTime.now();

  String dateFormat(DateTime dateTime) {
    return DateFormat("dd MMM").format(dateTime);
  }

  String sevenDays(DateTime dateTime) {
    var lastDays = DateTime(dateTime.year, dateTime.month, dateTime.day - 3);
    var nextDays = DateTime(dateTime.year, dateTime.month, dateTime.day + 3);
    return "${dateFormat(lastDays)} - ${dateFormat(nextDays)}";
  }

  String formatTimeOfDay(TimeOfDay time) {
    final hours = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minutes = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return "$hours : $minutes $period";
  }

}

class TableCalendar extends StatefulWidget {
  const TableCalendar({Key? key}) : super(key: key);

  @override
  State<TableCalendar> createState() => _TableCalendarState();
}

class _TableCalendarState extends State<TableCalendar> {
  late double _screenWidth;
  late DateTime _selectedDate;
  late List<DateTime> _sevenDays;
  DateTime? selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _sevenDays = List.generate(7, (index) => _selectedDate.add(Duration(days: index - 3)));
    selectedDay = _sevenDays[3];
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        showWeek(),
        const SizedBox(
          height: 20,
        ),
        selectOfWeek(),
      ],
    );
  }

  Row showWeek() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              DateTime changedTime = _selectedDate.add(const Duration(days: -7));
              _selectedDate = changedTime;
              _sevenDays = List.generate(7, (index) => _selectedDate.add(Duration(days: index - 3)));
            });
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.zero,
            child: const Icon(
              Icons.keyboard_arrow_left,
              size: 30,
              color: textPurple,
            ),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.dark().copyWith(
                    primaryColor: bgColor,
                    colorScheme: const ColorScheme.dark(
                      primary: white,
                    ),
                  ),
                  child: child ?? Container(),
                );
              },
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(DateTime.now().year - 2),
              lastDate: DateTime(DateTime.now().year + 2),
            );
            if (pickedDate != null && pickedDate != _selectedDate) {
              setState(() {
                _selectedDate = pickedDate;
                _sevenDays = List.generate(7, (index) => _selectedDate.add(Duration(days: index - 3)));
                selectedDay = _sevenDays[3];
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: cText("${GetDate().dateFormat(_selectedDate)} - ${GetDate().dateFormat(_selectedDate.add(const Duration(days: 6)))}", "Roboto", color: textPurple),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            setState(() {
              var changedTime = _selectedDate.add(const Duration(days: 7));
              _selectedDate = changedTime;
              _sevenDays = List.generate(7, (index) => _selectedDate.add(Duration(days: index - 3)));
            });
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.zero,
            child: const Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: textPurple,
            ),
          ),
        ),
      ],
    );
  }

  Container selectOfWeek() {
    return Container(
      clipBehavior: Clip.none,
      width: double.infinity,
      height: 75,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 7,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var currentDay = _sevenDays[index];
            var isSelected = currentDay == selectedDay;

            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      selectedDay = currentDay;
                    });
                  },
                  child: AnimatedContainer(
                    clipBehavior: Clip.none,
                    duration: const Duration(milliseconds: 50),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: isSelected ? Border.all(color: textPurple, width: 2) : null,
                    ),
                    padding: EdgeInsets.only(top: 8, bottom: 8, right: _screenWidth * 0.02, left: _screenWidth * 0.02),
                    child: SizedBox(
                      width: _screenWidth / 12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cText(
                            DateFormat('EEE').format(currentDay),
                            "Roboto",
                            fontSize: _screenWidth > 500 ? 16 : _screenWidth * 0.035,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? textPurple : Colors.white60,
                          ),
                          const SizedBox(height: 10),
                          cText(
                            DateFormat('dd').format(currentDay),
                            "Roboto",
                            fontSize: _screenWidth > 500 ? 16 : _screenWidth * 0.035,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? textPurple : Colors.white60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (isSelected)
                  const Positioned(
                    bottom: -4,
                    child: Icon(
                      Icons.circle,
                      color: textPurple,
                      size: 11,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

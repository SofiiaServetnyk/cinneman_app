import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/data/models/movies.dart';
import 'package:cinneman/features/authorization/presentation/custom_button.dart';
import 'package:cinneman/features/home/presentation/widgets/session_button.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  Movie movie;
  DateTime lastDay;

  CustomCalendar({Key? key, required this.movie, DateTime? lastDay})
      : this.lastDay = lastDay ??
            DateTime(DateTime.now().year, DateTime.now().month + 3, 0,
                DateTime.now().day),
        super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime focusedDay = DateTime.now();

  void onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      this.focusedDay = day;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      TableCalendar(
          daysOfWeekStyle:
              DaysOfWeekStyle(weekdayStyle: nunito, weekendStyle: nunito),
          rowHeight: 40,
          startingDayOfWeek: StartingDayOfWeek.monday,
          selectedDayPredicate: (day) => isSameDay(day, focusedDay),
          availableGestures: AvailableGestures.all,
          onDaySelected: onDaySelected,
          headerStyle: HeaderStyle(
            rightChevronIcon:
                Icon(Icons.arrow_circle_right, color: CustomColors.yellow1),
            leftChevronIcon:
                Icon(Icons.arrow_circle_left, color: CustomColors.yellow1),
            formatButtonTextStyle: nunito,
            titleTextStyle: nunito.s18,
            formatButtonVisible: false,
            titleCentered: true,
          ),
          focusedDay: focusedDay,
          firstDay: DateTime.now(),
          calendarStyle: CalendarStyle(
              weekendTextStyle: nunito.grey,
              selectedDecoration: BoxDecoration(
                color: CustomColors.yellow2,
                shape: BoxShape.circle,
              ),
              outsideTextStyle: nunito.grey,
              todayDecoration: BoxDecoration(
                  color: CustomColors.yellow1, shape: BoxShape.circle),
              defaultTextStyle: nunito,
              disabledTextStyle: nunito.grey),
          lastDay: widget.lastDay),
      const Divider(),
      const SizedBox(height: SizedBoxSize.sbs10),
      Container(child: Text("Sweet Showtimes:", style: nunito.black)),
      const SizedBox(height: SizedBoxSize.sbs10),
      Padding(
        padding: Paddings.all5,
        child: SizedBox(
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return SessionSelectionButton();
              }),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: CustomButton(onPressed: () {}, child: const Text('test')),
      ),
      SizedBox(height: SizedBoxSize.sbs25)
    ]);
  }
}

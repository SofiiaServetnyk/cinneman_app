import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/features/authorization/presentation/custom_button.dart';
import 'package:cinneman/features/home/presentation/widgets/session_button.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  CustomCalendar({Key? key}) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime today = DateTime.now();

  DateTime lastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 3, 0, DateTime.now().day);

  void onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      TableCalendar(
          rowHeight: 40,
          startingDayOfWeek: StartingDayOfWeek.monday,
          selectedDayPredicate: (day) => isSameDay(day, today),
          availableGestures: AvailableGestures.all,
          onDaySelected: onDaySelected,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          focusedDay: today,
          firstDay: today,
          lastDay: lastDay),
      const Divider(),
      const SizedBox(height: SizedBoxSize.sbs10),
      Container(child: const Text("Sessions:")),
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

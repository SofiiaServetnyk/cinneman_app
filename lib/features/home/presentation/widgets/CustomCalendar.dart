import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatelessWidget {
  CustomCalendar({Key? key}) : super(key: key);
  DateTime today = DateTime.now();
  DateTime lastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 3, 0, DateTime.now().day);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TableCalendar(
            focusedDay: this.today, firstDay: today, lastDay: lastDay));
  }
}

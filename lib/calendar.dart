import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'exams.dart';


class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final exams =
    ModalRoute.of(context)!.settings.arguments as List<ExamApplication>;
    return Scaffold(
      appBar: AppBar(
          title: Text("Exam dates")),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource(exams)),
        monthViewSettings: const MonthViewSettings(
            showAgenda: true,
            navigationDirection: MonthNavigationDirection.horizontal
        ),
        todayHighlightColor: Colors.blue,
        showNavigationArrow: true,
        // on
      ),
    );
  }

  List<Meeting> _getDataSource(exams) {
    final List<Meeting> meetings = <Meeting>[];
    exams.forEach((exam) => {
      meetings.add(Meeting(exam.course, exam.dateTime, exam.dateTime,
          Colors.primaries[Random().nextInt(Colors.primaries.length)]
          , true))
    });
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
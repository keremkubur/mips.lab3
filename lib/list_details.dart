import 'package:flutter/material.dart';
import 'exams.dart';

class ListDetailsScreen extends StatelessWidget {

  static const routeName = '/list_detail';
  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ExamApplication;
    return Scaffold(
      appBar: AppBar(title: Text(item.course)),
      body: Column(children: [
        Text(item.course),
        Text(item.dateTime.toString()),
      ]),
    );
  }
}
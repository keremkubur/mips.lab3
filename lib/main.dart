import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'bloc/bloc_list.dart';
import 'bloc/event_list.dart';
import 'bloc/state_list.dart';
import 'calendar.dart';
import 'exams.dart';
import 'list_details.dart';
import 'package:flutter/material.dart';
import 'package:native_notify/native_notify.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NativeNotify.initialize(3147, 'YkUjbbR200w3Na8HSLfWTC', null, null);

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<ListBloc>(
        create: (BuildContext context) =>
        ListBloc()..add(ListInitializedEvent()),
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  TextEditingController _c = TextEditingController();
  TextEditingController _year = TextEditingController();
  TextEditingController _month = TextEditingController();
  TextEditingController _day = TextEditingController();
  TextEditingController _hour = TextEditingController();
  TextEditingController _minute = TextEditingController();

  @override
  void initState() {
    _c = TextEditingController();
    _year = TextEditingController();
    _month = TextEditingController();
    _day = TextEditingController();
    _hour = TextEditingController();
    _minute = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _c.dispose();
    _year.dispose();
    _month.dispose();
    _day.dispose();
    _hour.dispose();
    _minute.dispose();
    super.dispose();
  }

  bool isVisible = false;

  final String title = "Student Organizer";

  String _course = "";
  String _y = "2022";
  String _m = "2";
  String _d = "1";
  String _h = "18";
  String _min = "45";

  void addExamApplication(BuildContext ctx, course, year, month, day, hour, minute) {
    final bloc = BlocProvider.of<ListBloc>(ctx);
    bloc.add(ListElementAddedEvent(
        elem: ExamApplication(
            course: course,
            dateTime: DateTime(year, month, day, hour, minute))));
  }

  void _deleteItem(BuildContext ctx, ExamApplication examApplication) {
    final bloc = BlocProvider.of<ListBloc>(ctx);
    bloc.add(ListElementDeletedEvent(elem: examApplication));
  }

  void _showHideAddMenu() {
    setState(() => isVisible = !isVisible);
  }

  dynamic _createAppBar(BuildContext context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
      middle: Text(title),
      trailing: Row(
        children: [
          GestureDetector(
            onTap: () => _showHideAddMenu(),
            child: !isVisible
                ? const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                CupertinoIcons.add,
              ),
            )
                : const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                CupertinoIcons.minus,
              ),
            ),
          ),
        ],
      ),
    )
        : AppBar(title: Text(title), actions: <Widget>[
      BlocBuilder<ListBloc, ListState>(builder: (context, state) {
        return state.runtimeType == ListEmptyState
            ? GestureDetector(
          onTap: () => null,
          child: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.calendar_today),
          ),
        )
            : GestureDetector(
          onTap: () => _openCalendarScreen(
              context, (state as ListElementsState).elems),
          child: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.calendar_today),
          ),
        );
      }),
      GestureDetector(
        onTap: () => _showHideAddMenu(),
        child: !isVisible
            ? const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(
            Icons.add,
          ),
        )
            : const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(
            Icons.remove,
          ),
        ),
      ),
    ]);
  }

  Widget _createBody(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: isVisible,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextField(
                  onChanged: (v) => setState(() {
                    _course = v;
                  }),
                  controller: _c,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter course name',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                      width: double.infinity,
                      child: TextField(
                        onChanged: (v) => setState(() {
                          _y = v;
                        }),
                        controller: _year,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'YY',
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      width: double.infinity,
                      child: TextField(
                        onChanged: (v) => setState(() {
                          _m = v;
                        }),
                        controller: _month,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'MM',
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                      width: double.infinity,
                      child: TextField(
                        onChanged: (v) => setState(() {
                          _d = v;
                        }),
                        controller: _day,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'DD',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 8, 5, 0),
                      width: double.infinity,
                      child: TextField(
                        onChanged: (v) => setState(() {
                          _h = v;
                        }),
                        controller: _hour,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'HH',
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 8, 10, 0),
                      width: double.infinity,
                      child: TextField(
                        onChanged: (v) => setState(() {
                          _min = v;
                        }),
                        controller: _minute,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'MM',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  child: const Text("Add a exam to schedule"),
                  onPressed: () {
                    setState(() {
                      _course = _c.text;
                      _y = _year.text;
                      _m = _month.text;
                      _d = _day.text;
                      _h = _hour.text;
                      _min = _minute.text;
                      addExamApplication(
                          context,
                          _course,
                          int.parse(_y),
                          int.parse(_m),
                          int.parse(_d),
                          int.parse(_h),
                          int.parse(_min));
                      _c.text = "";
                      _year.text = "";
                      _month.text = "";
                      _day.text = "";
                      _hour.text = "";
                      _minute.text = "";
                    });
                  },
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<ListBloc, ListState>(builder: (context, state) {
            return state.runtimeType == ListEmptyState
                ? const Center(
              child: Text("No elements"),
            )
                : Center(
              child: ListView.builder(
                itemCount: (state as ListElementsState).elems?.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: ListTile(
                      title: Text(
                        (state as ListElementsState).elems![index].course,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark),
                      ),
                      subtitle: Text(
                        "${(state).elems![index].dateTime.year.toString()}-${(state).elems![index].dateTime.month.toString().padLeft(2, '0')}-${(state).elems![index].dateTime.day.toString().padLeft(2, '0')} ${(state).elems![index].dateTime.hour.toString().padLeft(2, '0')}:${(state).elems![index].dateTime.minute.toString().padLeft(2, '0')}",
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteItem(context, (state as ListElementsState).elems![index]),
                      ),
                      onTap: () => _showDetail(context, (state as ListElementsState).elems![index]),
                    ),
                  );
                },
              ),
            );
          }),
        )
      ],
    );
  }

  void _showDetail(BuildContext context, element) {
    Navigator.of(context).pushNamed(
      ListDetailsScreen.routeName,
      arguments: element,
    );
  }

  void _openCalendarScreen(BuildContext context, elements) {
    Navigator.of(context).pushNamed(
      '/calendar',
      arguments: elements,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
      home: CupertinoPageScaffold(
        child: _createBody(context),
        navigationBar: _createAppBar(context),
      ),
    )

    :MaterialApp(
      title: title,
      initialRoute: '/',
      routes: {
        '/': (ctx) => Scaffold(
          appBar: _createAppBar(context),
          body: _createBody(context),
        ),
        ListDetailsScreen.routeName: (ctx) => ListDetailsScreen(),
        '/calendar': (ctx) => CalendarScreen(),
      },
    );
  }
}
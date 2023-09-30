import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'routes/route.dart' as route;
import 'package:calendar_view/calendar_view.dart';
import 'models/event.dart';


DateTime get _now => DateTime.now();


void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider<Event>(
      controller: EventController<Event>()..addAll(_events),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: route.controller,
        initialRoute: route.loginPage,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

List<CalendarEventData<Event>> _events = [
  CalendarEventData(
    color: Colors.red,
    date: _now,
    endDate: _now.add(Duration(days: 5)),
    event: Event(title: "Joe's Birthday"),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
   CalendarEventData(
    color: Colors.green,
    date: _now.add(Duration(days: 7)),
    endDate: _now.add(Duration(days: 9)),
    event: Event(title: "Joe's Birthday"),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
];

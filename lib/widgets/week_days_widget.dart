import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Widget that represents week days in row above calendar month view.
class WeekDaysWidget extends StatelessWidget {
   WeekDaysWidget({
    required this.day,
    super.key,
  });

  /// [WeekDay] value from [WeekDaysBuilder].
  final WeekDay day;

    final violet = Color(0xff7F51F5);

final eventColors = [
  Color(0xff82D964),
  Color(0xffE665FD),
  Color(0xffF7980B),
  Color(0xfff2d232),
  Color(0xffFC6054),
  Color(0xffBEBEBE),
];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Center(
        child: Text(
          describeEnum(day).substring(0, 1).toUpperCase(),
          style: TextStyle(
            color: violet.withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
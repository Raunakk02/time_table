import 'package:flutter/material.dart';

class WeekdayEventsScreen extends StatelessWidget {
  final String weekDayText;

  WeekdayEventsScreen(this.weekDayText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          weekDayText,
        ),
      ),
    );
  }
}

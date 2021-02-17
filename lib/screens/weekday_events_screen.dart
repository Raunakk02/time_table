import 'package:flutter/material.dart';
import 'package:time_table/widgets/event_input.dart';

import '../models/event.dart';
import '../widgets/event_card.dart';

class WeekdayEventsScreen extends StatefulWidget {
  final String weekDayText;

  WeekdayEventsScreen(this.weekDayText);

  @override
  _WeekdayEventsScreenState createState() => _WeekdayEventsScreenState();
}

class _WeekdayEventsScreenState extends State<WeekdayEventsScreen> {
  List<Event> weekDayEventsList = [];

  void _addWeekdayEvent(
    String evTitle,
    String evDescription,
    TimeOfDay evStartTime,
    TimeOfDay evEndTime,
  ) {
    print(evTitle);
    print(evDescription);
    if (evTitle.isEmpty || evDescription.isEmpty) return;

    setState(() {
      weekDayEventsList.add(
        Event(
          id: DateTime.now().toString(),
          title: evTitle,
          description: evDescription,
          weekDay: widget.weekDayText,
          startTime: evStartTime,
          endTime: evEndTime,
        ),
      );
    });

    Navigator.of(context).pop();
  }

  void _openModalBottomSheet() {
    showModalBottomSheet(
      builder: (_) {
        return EventInput(_addWeekdayEvent);
      },
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: weekDayEventsList.length,
        itemBuilder: (ctx, i) {
          return EventCard(
            weekDayEvent: weekDayEventsList[i],
            weekDayText: widget.weekDayText,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openModalBottomSheet,
        child: Icon(
          Icons.note_add_rounded,
          size: 30,
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
    );
  }
}

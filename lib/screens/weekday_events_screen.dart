import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_table/providers/events_provider.dart';
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
  var _init = false;
  EventsProvider eventsProvider;
  List<Event> allEventsList;
  List<Event> weekDayEventsList;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (!_init) {
      eventsProvider = Provider.of<EventsProvider>(context);
      allEventsList = eventsProvider.events;
      _init = false;
    }
  }

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
      eventsProvider.addEvent(
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
    weekDayEventsList =
        allEventsList.where((e) => e.weekDay == widget.weekDayText).toList();
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_table/providers/events_provider.dart';

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

  final List<MaterialAccentColor> availableCardColors = [
    Colors.pinkAccent,
    Colors.cyanAccent,
    Colors.lightGreenAccent,
    Colors.purpleAccent,
    Colors.amberAccent,
    Colors.deepOrangeAccent,
  ];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (!_init) {
      eventsProvider = Provider.of<EventsProvider>(context);
      // eventsProvider.initEvents();
      allEventsList = eventsProvider.events;
      _init = false;
    }
  }

  void delEvent(Event e) {
    eventsProvider.deleteEvent(e);
  }

  MaterialAccentColor cardColorSelector() {
    final random = Random();
    final index = random.nextInt(6);
    return availableCardColors[index];
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
            deleteEvent: delEvent,
            cardColor: cardColorSelector(),
          );
        },
      ),
    );
  }
}

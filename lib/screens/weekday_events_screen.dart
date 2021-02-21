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
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Are you sure?'),
        titleTextStyle: Theme.of(context).textTheme.button,
        backgroundColor:
            Theme.of(context).buttonColor.withAlpha(230).withOpacity(1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        actions: [
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              eventsProvider.deleteEvent(e);
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
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
    weekDayEventsList.sort((ev1, ev2) {
      var ev1StartTime = ev1.startTime.hour + (ev1.startTime.minute / 60);
      var ev2StartTime = ev2.startTime.hour + (ev2.startTime.minute / 60);

      if (ev1StartTime < ev2StartTime) {
        return -1;
      } else {
        if (ev1StartTime > ev2StartTime) {
          return 1;
        } else {
          return 0;
        }
      }
    });
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

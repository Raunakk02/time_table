import 'package:flutter/material.dart';
import 'package:time_table/models/event.dart';

import 'event_card.dart';

class WeekdayEventsList extends StatelessWidget {
  final List<Event> weekDayEventsList;
  final String weekDayText;
  final Function delEvent;
  final Function cardColorSelector;

  WeekdayEventsList({
    @required this.weekDayEventsList,
    @required this.weekDayText,
    @required this.delEvent,
    @required this.cardColorSelector,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weekDayEventsList.length,
      itemBuilder: (ctx, i) {
        return EventCard(
          weekDayEvent: weekDayEventsList[i],
          weekDayText: weekDayText,
          deleteEvent: delEvent,
          cardColor: cardColorSelector(),
        );
      },
    );
  }
}

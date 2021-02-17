import 'package:flutter/material.dart';
import 'package:time_table/screens/event_details_screen.dart';

import '../models/event.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key key,
    @required this.weekDayEvent,
    @required this.weekDayText,
  }) : super(key: key);

  final Event weekDayEvent;
  final String weekDayText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(EventDetailsScreen.routeName, arguments: {
          'weekDayEvent': weekDayEvent,
          'weekDayText': weekDayText,
        });
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
          child: ListTile(
            title: Text(
              weekDayEvent.title,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              weekDayEvent.description,
              overflow: TextOverflow.ellipsis,
            ),
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.cyan,
              ),
              width: 60,
              height: 50,
              child: FittedBox(
                child: Text(
                  '${weekDayEvent.startTime.format(context)}\n-\n${weekDayEvent.endTime.format(context)}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

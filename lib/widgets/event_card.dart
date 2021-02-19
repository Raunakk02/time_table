import 'package:flutter/material.dart';
import 'package:time_table/screens/event_details_screen.dart';

import '../models/event.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key key,
    @required this.weekDayEvent,
    @required this.weekDayText,
    @required this.deleteEvent,
    @required this.cardColor,
  }) : super(key: key);

  final Event weekDayEvent;
  final String weekDayText;
  final Function deleteEvent;
  final MaterialAccentColor cardColor;

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
        color: cardColor,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
          child: ListTile(
            tileColor: Colors.black54,
            leading: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.pink, Colors.orange],
                ),
              ),
              width: 80,
              height: 80,
              child: FittedBox(
                child: Text(
                  '${weekDayEvent.startTime.format(context)}\n|\n${weekDayEvent.endTime.format(context)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            title: Text(
              weekDayEvent.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              weekDayEvent.description,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteEvent(weekDayEvent),
            ),
          ),
        ),
      ),
    );
  }
}

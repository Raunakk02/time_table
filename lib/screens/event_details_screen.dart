import 'package:flutter/material.dart';
import 'package:time_table/models/event.dart';

class EventDetailsScreen extends StatelessWidget {
  static const routeName = '/event-details-screen';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    String weekDayText = args['weekDayText'];
    Event weekDayEvent = args['weekDayEvent'];

    return Scaffold(
      appBar: AppBar(
        title: Text('${weekDayEvent.weekDay} : ${weekDayEvent.title}'),
      ),
    );
  }
}

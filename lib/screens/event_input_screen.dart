import 'package:flutter/material.dart';
import 'package:time_table/widgets/event_input.dart';

class EventInputScreen extends StatelessWidget {
  static const routeName = '/event-input-screen';
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final Function _addNewEvent = args['addNewEvent'];
    final List<String> _weekDays = args['weekDays'];
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.cyan),
        title: Text('Enter New Event'),
      ),
      body: EventInput(_addNewEvent, _weekDays),
    );
  }
}

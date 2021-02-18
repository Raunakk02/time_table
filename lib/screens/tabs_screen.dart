import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_table/models/event.dart';
import 'package:time_table/providers/events_provider.dart';
import 'package:time_table/screens/weekday_events_screen.dart';
import 'package:time_table/widgets/event_input.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  var _init = false;

  int todayWeekDay;
  EventsProvider eventsProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todayWeekDay = DateTime.now().weekday;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_init) {
      eventsProvider = Provider.of<EventsProvider>(context);
      _init = false;
    }
  }

  void _addWeekdayEvent(
    String evTitle,
    String evDescription,
    String selectedWeekDay,
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
          weekDay: selectedWeekDay,
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
        return EventInput(_addWeekdayEvent, weekDays);
      },
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: todayWeekDay == 6 ? 0 : todayWeekDay - 1,
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Time Table',
            style: TextStyle(
              color: Theme.of(context).textTheme.headline6.color,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(weekDays[0]),
              ),
              Tab(
                child: Text(weekDays[1]),
              ),
              Tab(
                child: Text(weekDays[2]),
              ),
              Tab(
                child: Text(weekDays[3]),
              ),
              Tab(
                child: Text(weekDays[4]),
              ),
              Tab(
                child: Text(weekDays[5]),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WeekdayEventsScreen(weekDays[0]),
            WeekdayEventsScreen(weekDays[1]),
            WeekdayEventsScreen(weekDays[2]),
            WeekdayEventsScreen(weekDays[3]),
            WeekdayEventsScreen(weekDays[4]),
            WeekdayEventsScreen(weekDays[5]),
          ],
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
      ),
    );
  }
}

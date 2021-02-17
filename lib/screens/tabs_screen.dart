import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_table/providers/events_provider.dart';
import 'package:time_table/screens/weekday_events_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<String> weekDay = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  int currentWeekDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentWeekDay = DateTime.now().weekday;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => EventsProvider(),
        ),
      ],
      child: DefaultTabController(
        initialIndex: currentWeekDay == 6 ? 0 : currentWeekDay - 1,
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
                  child: Text(weekDay[0]),
                ),
                Tab(
                  child: Text(weekDay[1]),
                ),
                Tab(
                  child: Text(weekDay[2]),
                ),
                Tab(
                  child: Text(weekDay[3]),
                ),
                Tab(
                  child: Text(weekDay[4]),
                ),
                Tab(
                  child: Text(weekDay[5]),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              WeekdayEventsScreen(weekDay[0]),
              WeekdayEventsScreen(weekDay[1]),
              WeekdayEventsScreen(weekDay[2]),
              WeekdayEventsScreen(weekDay[3]),
              WeekdayEventsScreen(weekDay[4]),
              WeekdayEventsScreen(weekDay[5]),
            ],
          ),
        ),
      ),
    );
  }
}

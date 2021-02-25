import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:time_table/Notifications/local_notifications.dart' as noti;
import 'package:time_table/models/event.dart';

import 'package:time_table/providers/events_provider.dart';
import 'package:time_table/screens/event_input_screen.dart';

import 'package:time_table/screens/weekday_events_screen.dart';

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
  var _isLoaded = false;

  int todayWeekDay;
  Event obtainedEvent;
  EventsProvider eventsProvider;
  // FlutterLocalNotificationsPlugin fltrNotifications;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todayWeekDay = DateTime.now().weekday;
    // var androidInitialize = AndroidInitializationSettings('app_icon');
    // var iosInitialize = IOSInitializationSettings();
    // var initializationSettings =
    //     InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    // fltrNotifications = FlutterLocalNotificationsPlugin();
    // fltrNotifications.initialize(initializationSettings);
    // noti.NotificationManager().initNotifications();
  }

  // Future _showNotifications(Event e) async {
  //   var androidDetails = AndroidNotificationDetails(
  //     'channel ID',
  //     'time table',
  //     'New event',
  //     importance: Importance.max,
  //   );
  //   var iosDetails = IOSNotificationDetails();
  //   var generalNotificationDetails = NotificationDetails(
  //     android: androidDetails,
  //     iOS: iosDetails,
  //   );
  //   print('Local noti triggered!! RK');

  //   await fltrNotifications.show(0, 'AI', 'No Att', generalNotificationDetails);
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_init) {
      eventsProvider = Provider.of<EventsProvider>(context);
      // eventsProvider.initEvents();

      _init = false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Hive.close();
  }

  void _addWeekdayEvent(
    String evTitle,
    String evDescription,
    String selectedWeekDay,
    DateTime evStartDate,
    TimeOfDay evStartTime,
  ) {
    print(evTitle);
    print(evDescription);
    if (evTitle.isEmpty ||
        evDescription.isEmpty ||
        !weekDays.contains(selectedWeekDay) ||
        evStartTime == null ||
        evStartDate == null ||
        evStartDate.weekday == 7) return;
    obtainedEvent = Event(
      id: DateTime.now().toIso8601String(),
      title: evTitle,
      description: evDescription,
      weekDay: selectedWeekDay,
      startDate: evStartDate,
      startTime: evStartTime,
    );

    setState(() {
      eventsProvider.addEvent(
        obtainedEvent,
        // noti.NotificationManager().showNotification,
      );
    });
    // _showNotifications(obtainedEvent);

    Navigator.of(context).pop();
  }

  // void _openModalBottomSheet() {
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     builder: (_) {
  //       return EventInput(_addWeekdayEvent, weekDays);
  //     },
  //     context: context,
  //   );
  // }

  void _openEventInputScreen() {
    Navigator.of(context).pushNamed(
      EventInputScreen.routeName,
      arguments: {
        'addNewEvent': _addWeekdayEvent,
        'weekDays': weekDays,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: todayWeekDay == 7 ? 0 : todayWeekDay - 1,
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/app_icon.png',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).viewPadding.top + 10, //30,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Time Table',
              ),
            ],
          ),
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.bodyText1,
            unselectedLabelColor: Colors.white30,
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 11,
                    ),
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
        body: FutureBuilder(
          future: Hive.openBox('events'),
          builder: (_, eventsSnapshot) {
            if (!eventsSnapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              if (!_isLoaded) {
                eventsProvider.initEvents();
                _isLoaded = true;
              }

              return TabBarView(
                children: [
                  WeekdayEventsScreen(weekDays[0]),
                  WeekdayEventsScreen(weekDays[1]),
                  WeekdayEventsScreen(weekDays[2]),
                  WeekdayEventsScreen(weekDays[3]),
                  WeekdayEventsScreen(weekDays[4]),
                  WeekdayEventsScreen(weekDays[5]),
                ],
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openEventInputScreen,
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

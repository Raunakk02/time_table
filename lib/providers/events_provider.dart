import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_table/Hive/hive_init.dart';
import 'package:time_table/Notifications/callback.dart';
import '../Notifications/local_notifications.dart' as noti;

import '../models/event.dart';

Future<dynamic> Function() _showNotifications;
Event obtainedEvent;

class EventsProvider with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events {
    return [..._events];
  }

  void addEvent(Event e, Future Function() showNoti) async {
    _events.add(e);
    Hive.box('events').add(e).then((_) {
      obtainedEvent = e;
      _showNotifications = showNoti;
      // _showNotifications();
      noti.NotificationManager().initEvent(e);
      var now = DateTime.now();
      print('Initializing weekDay alarm !!!!! LOL');
      AndroidAlarmManager.periodic(
        Duration(minutes: 2),
        DateTime.parse(e.id).millisecondsSinceEpoch % 1000000,
        trigger,
        rescheduleOnReboot: true,
        exact: true,
        startAt: DateTime(
          now.year,
          now.month,
          now.day,
          e.startTime.hour,
          e.startTime.minute,
        ),
        wakeup: true,
      );
    });

    notifyListeners();
  }

  void deleteEvent(Event e) async {
    var eventsBox = Hive.box('events');
    var eventsBoxList = eventsBox.values.toList();

    for (int i = 0; i < eventsBox.length; i++) {
      Event extractedEvent = eventsBoxList[i];
      if (extractedEvent == e) {
        //Delete Event from hive Box
        await eventsBox.deleteAt(i);

        //Remove Event from _events array
        _events.removeAt(i);

        //Cancel alarm for the deleted event
        var alarmId =
            DateTime.parse(extractedEvent.id).millisecondsSinceEpoch % 1000000;
        var cancelSuccess = await AndroidAlarmManager.cancel(alarmId);
        if (cancelSuccess) {
          print('Alarm Canceled for id: $alarmId');
        } else {
          print('Alarm Not Canceled for id: $alarmId');
        }
        break;
      }
    }
    notifyListeners();
  }

  Future<Event> getEventForAlarm(triggeredAlarmId) async {
    await initHive();
    var eventsBox = await Hive.openBox('events');
    var eventsBoxList = eventsBox.values.toList();

    for (int i = 0; i < eventsBox.length; i++) {
      Event extractedEvent = eventsBoxList[i];
      int extractedEventAlarmId =
          DateTime.parse(extractedEvent.id).millisecondsSinceEpoch % 1000000;
      if (extractedEventAlarmId == triggeredAlarmId) {
        return extractedEvent;
      }
    }

    return Event(
      id: DateTime.now().toIso8601String(),
      description: 'example',
      title: 'Sample',
      startTime: TimeOfDay(hour: 16, minute: 20),
      endTime: TimeOfDay(hour: 17, minute: 00),
      weekDay: 'Thursday',
    );
  }

  void initEvents() {
    _events.clear();

    var eventsBox = Hive.box('events');
    print('Box Events Length : ${eventsBox.length}');
    var eventsBoxList = eventsBox.values.toList();

    for (int i = 0; i < eventsBox.length; i++) {
      Event extractedEvent = eventsBoxList[i];
      _events.add(extractedEvent);
    }
    print('App Events Length : ${_events.length}');
  }
}

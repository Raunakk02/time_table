import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/event.dart';

Future Function(Event) _showNotifications;
Event obtainedEvent;

void trigger(int id) {
  print('Weekday Alaram Triggered, id: $id');
  _showNotifications(obtainedEvent);
}

class EventsProvider with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events {
    return [..._events];
  }

  void addEvent(Event e, Function showNoti) async {
    _events.add(e);
    Hive.box('events').add(e).then((boxId) {
      obtainedEvent = e;
      _showNotifications = showNoti;
      var now = DateTime.now();
      print('Initializing weekDay alarm !!!!! LOL');
      AndroidAlarmManager.periodic(
        Duration(minutes: 2),
        boxId,
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
        await eventsBox.deleteAt(i);
        _events.removeAt(i);
        var cancelSuccess = await AndroidAlarmManager.cancel(i);
        if (cancelSuccess) {
          print('Alarm Canceled for id: $i');
        } else {
          print('Alarm Not Canceled for id: $i');
        }
        break;
      }
    }
    notifyListeners();
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

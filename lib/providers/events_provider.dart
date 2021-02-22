import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/event.dart';

void trigger(int id) {
  id += 1;
  print('Weekday Alaram Triggered');
}

class EventsProvider with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events {
    return [..._events];
  }

  void addEvent(Event e) {
    _events.add(e);
    Hive.box('events').add(e).then((_) {
      var now = DateTime.now();
      print('Initializing weekDay alarm !!!!! LOL');
      AndroidAlarmManager.periodic(
        Duration(minutes: 2),
        0,
        trigger,
        rescheduleOnReboot: true,
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

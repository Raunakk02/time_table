import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/event.dart';

class EventsProvider with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events {
    return [..._events];
  }

  void addEvent(Event e) {
    _events.add(e);
    Hive.box('events').add(e);
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

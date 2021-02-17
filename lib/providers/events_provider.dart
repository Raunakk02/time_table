import 'package:flutter/foundation.dart';

import '../models/event.dart';

class EventsProvider with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events {
    return [..._events];
  }

  void addEvent(Event e) {
    _events.add(e);

    notifyListeners();
  }
}

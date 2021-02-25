import 'package:time_table/models/event.dart';
import 'package:time_table/providers/events_provider.dart';

import './local_notifications.dart' as noti;

void trigger(int id) async {
  print('Weekday Alaram Triggered, id: $id');
  noti.NotificationManager n = noti.NotificationManager();
  n.initNotifications();
  Event e = await EventsProvider().getEventForAlarm(id);
  if (e != null) {
    n.initEvent(e);
    n.showNotification();
  }
}

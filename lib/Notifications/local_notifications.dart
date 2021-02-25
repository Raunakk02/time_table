import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:time_table/models/event.dart';

class NotificationManager {
  FlutterLocalNotificationsPlugin fltrNotifications =
      FlutterLocalNotificationsPlugin();

  Event obtainedEvent;

  void initNotifications() async {
    var androidInitialize =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var iosInitialize = IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    await fltrNotifications.initialize(initializationSettings);
  }

  void initEvent(Event e) {
    obtainedEvent = e;
  }

  Future showNotification() async {
    var androidDetails = AndroidNotificationDetails(
      'channel ID',
      'time table',
      'New event',
      importance: Importance.max,
    );
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    print('Local noti triggered!! RK');
    var alarmId =
        DateTime.parse(obtainedEvent.id).millisecondsSinceEpoch % 1000000;

    await fltrNotifications.show(alarmId, obtainedEvent.title,
        obtainedEvent.description, generalNotificationDetails);
  }
}

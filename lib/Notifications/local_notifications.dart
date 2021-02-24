import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:time_table/models/event.dart';

FlutterLocalNotificationsPlugin fltrNotifications =
    FlutterLocalNotificationsPlugin();

void initNotifications() async {
  var androidInitialize = AndroidInitializationSettings('app_icon');
  var iosInitialize = IOSInitializationSettings();
  var initializationSettings =
      InitializationSettings(android: androidInitialize, iOS: iosInitialize);

  await fltrNotifications.initialize(initializationSettings);
}

Future showNotification(Event e) async {
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
  var alarmId = DateTime.parse(e.id).millisecondsSinceEpoch % 1000000;

  await fltrNotifications.show(
      alarmId, e.title, e.description, generalNotificationDetails);
}

import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:time_table/models/event.dart';

import './providers/events_provider.dart';

import './screens/event_details_screen.dart';
import './screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(EventAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EventsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Time Table',
        color: Colors.orange,
        theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 20,
                    color: Colors.orange,
                  ),
                ),
            color: Colors.transparent,
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  color: Colors.orange,
                ),
              ),
        ),
        routes: {
          '/': (_) => TabsScreen(),
          EventDetailsScreen.routeName: (_) => EventDetailsScreen(),
        },
      ),
    );
  }
}

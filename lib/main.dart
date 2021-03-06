import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:time_table/Hive/hive_init.dart';
import 'package:time_table/models/event.dart';
import 'package:time_table/screens/event_input_screen.dart';

import './providers/events_provider.dart';

import './screens/event_details_screen.dart';
import './screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);
  // Hive.registerAdapter(TimeOfDayAdapter());
  // Hive.registerAdapter(EventAdapter());

  await initHive();

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
                    fontSize: 26,
                    color: Colors.orange,
                  ),
                ),
            color: Colors.transparent,
          ),
          buttonColor: Colors.orange,
          buttonTheme: ThemeData.dark().buttonTheme.copyWith(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Comfortaa',
                  color: Colors.orange,
                ),
                bodyText1: TextStyle(
                  fontFamily: 'Comfortaa',
                  color: Colors.orange,
                ),
                button: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        routes: {
          '/': (_) => TabsScreen(),
          EventInputScreen.routeName: (_) => EventInputScreen(),
          EventDetailsScreen.routeName: (_) => EventDetailsScreen(),
        },
      ),
    );
  }
}

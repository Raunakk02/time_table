import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:provider/provider.dart';
import 'package:time_table/providers/events_provider.dart';

import './screens/event_details_screen.dart';
import './screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
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

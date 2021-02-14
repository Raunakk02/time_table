import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: HomeScreen(),
    );
  }
}

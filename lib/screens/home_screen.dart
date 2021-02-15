import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<String> weekDay = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Time Table',
          style: TextStyle(
            color: Theme.of(context).textTheme.headline6.color,
          ),
        ),
      ),
      body: Container(),
    );
  }
}

int timeOfDay(i) {
  return 8 + (i / 6) < 12
      ? (8 + (i / 6)).toInt()
      : 8 + (i / 6) == 12
          ? 12
          : ((8 + (i / 6)) % 12).toInt();
}

Widget _buildTimeColumn(int i) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
    color: Colors.white,
    child: Text(
        8 + (i / 6) < 12 ? '${timeOfDay(i)}:00 AM' : '${timeOfDay(i)}:00 PM'),
  );
}

Widget _buildTimeTableCells() {
  return Container(
    margin: EdgeInsets.all(0.5),
    color: Colors.white,
  );
}

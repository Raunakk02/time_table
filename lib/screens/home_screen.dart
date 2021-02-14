import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              color: Colors.white,
            ),
          ),
          Flexible(
            flex: 8,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              color: Colors.orange,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: 66,
                itemBuilder: (ctx, i) {
                  return i % 6 == 0
                      ? _buildTimeColumn(i)
                      : _buildTimeTableCells();
                },
              ),
            ),
          ),
        ],
      ),
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

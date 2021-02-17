import 'package:flutter/material.dart';

class EventInput extends StatefulWidget {
  final void Function(
    String evTitle,
    String evDescription,
    TimeOfDay evStartTime,
    TimeOfDay evEndTime,
  ) addNewEvent;

  EventInput(this.addNewEvent);

  @override
  _EventInputState createState() => _EventInputState();
}

class _EventInputState extends State<EventInput> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  TimeOfDay startTime;
  TimeOfDay endTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime = TimeOfDay.now();
    endTime = TimeOfDay.now();
  }

  void selectStartTime() async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      cancelText: 'Cancel',
      confirmText: 'Confirm',
    );

    if (selectedTime != null) {
      setState(() {
        startTime = selectedTime;
      });
    }
  }

  void selectEndTime() async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      cancelText: 'Cancel',
      confirmText: 'Confirm',
    );

    if (selectedTime != null) {
      setState(() {
        endTime = selectedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              maxLength: 40,
              maxLengthEnforced: true,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                color: Colors.white,
              ),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              style: TextStyle(
                color: Colors.white,
              ),
              maxLength: 60,
              maxLengthEnforced: true,
              controller: descriptionController,
            ),
            Row(
              children: [
                Text(
                  'Start Time : ${startTime.format(context)}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.timer),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    selectStartTime();
                  },
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'End Time : ${endTime.format(context)}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.timer),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    selectEndTime();
                  },
                )
              ],
            ),
            RaisedButton(
              child: Text('Add Event'),
              color: Theme.of(context).textTheme.headline6.color,
              onPressed: () {
                widget.addNewEvent(
                  titleController.text,
                  descriptionController.text,
                  startTime,
                  endTime,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

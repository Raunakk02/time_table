import 'package:flutter/material.dart';

class EventInput extends StatefulWidget {
  final void Function(
    String evTitle,
    String evDescription,
    String selectedWeekDay,
    TimeOfDay evStartTime,
    TimeOfDay evEndTime,
  ) addNewEvent;

  final List<String> weekDays;

  EventInput(this.addNewEvent, this.weekDays);

  @override
  _EventInputState createState() => _EventInputState();
}

class _EventInputState extends State<EventInput> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedWeekDay;
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

  TextStyle labelTextStyle() {
    return TextStyle(
      color: Colors.white,
    );
  }

  DropdownMenuItem _buildDropdownMenuItem(int weekDayIndex) {
    return DropdownMenuItem(
      child: Text(widget.weekDays[weekDayIndex]),
      value: widget.weekDays[weekDayIndex],
    );
  }

  TextField _buildTextField(
      String label, int length, bool enableNext, TextEditingController tec) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      maxLength: length,
      maxLengthEnforced: true,
      textInputAction: enableNext ? TextInputAction.next : TextInputAction.done,
      style: labelTextStyle(),
      controller: tec,
    );
  }

  Row _buildSelectTimeRow(
      String label, TimeOfDay time, Function selectTimeFunc) {
    return Row(
      children: [
        Text(
          '$label Time : ${time.format(context)}',
          style: labelTextStyle(),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.timer),
          color: Theme.of(context).accentColor,
          onPressed: () {
            selectTimeFunc();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildTextField('Title', 40, true, titleController),
              _buildTextField('Description', 60, false, descriptionController),
              Row(
                children: [
                  Text(
                    'Select week day : ',
                    style: labelTextStyle(),
                  ),
                  Spacer(),
                  DropdownButton(
                    onChanged: (chosenWeekDay) {
                      setState(() {
                        selectedWeekDay = chosenWeekDay;
                      });
                      print('selected: $selectedWeekDay');
                    },
                    hint: Text('Pick a day...'),
                    value: selectedWeekDay,
                    style: labelTextStyle(),
                    items: [
                      _buildDropdownMenuItem(0),
                      _buildDropdownMenuItem(1),
                      _buildDropdownMenuItem(2),
                      _buildDropdownMenuItem(3),
                      _buildDropdownMenuItem(4),
                      _buildDropdownMenuItem(5),
                    ],
                  ),
                ],
              ),
              _buildSelectTimeRow('Start', startTime, selectStartTime),
              SizedBox(height: 20),
              _buildSelectTimeRow('End', endTime, selectEndTime),
              RaisedButton(
                child: Text('Add Event'),
                color: Theme.of(context).textTheme.headline6.color,
                onPressed: () {
                  widget.addNewEvent(
                    titleController.text,
                    descriptionController.text,
                    selectedWeekDay,
                    startTime,
                    endTime,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

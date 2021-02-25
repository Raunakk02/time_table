import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventInput extends StatefulWidget {
  final void Function(
    String evTitle,
    String evDescription,
    String selectedWeekDay,
    DateTime evStartDate,
    TimeOfDay evStartTime,
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
  DateTime startDate;
  TimeOfDay startTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime = TimeOfDay.now();
    startDate = null;
  }

  void validateAndAddEvent() async {
    if (titleController.text.isEmpty) {
      await showErrorDialog('Title can\'t be empty !');
    }
    if (descriptionController.text.isEmpty) {
      await showErrorDialog('Description can\'t be empty !');
    }
    // if (!widget.weekDays.contains(selectedWeekDay)) {
    //   await showErrorDialog('Please select a weekday !');
    // }
    // if (startTime == endTime) {
    //   await showErrorDialog('Start time and end time can\'t be same');
    // }
    if (startDate == null) {
      await showErrorDialog('Please pick Event Date !');
    }
    if (startDate != null) {
      if (startDate.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
        await showErrorDialog('Event Date can\'t be before today !');
      }
    }
    if (startDate != null) {
      if (startDate.weekday == 7) {
        await showErrorDialog(
            'Please select a day other than sunday !\n PS: Rest on sunday :)');
      }
    }

    if (startDate != null) {
      selectedWeekDay = widget.weekDays[startDate.weekday - 1];
      widget.addNewEvent(
        titleController.text,
        descriptionController.text,
        selectedWeekDay,
        startDate,
        startTime,
      );
    }
  }

  Future showErrorDialog(String msg) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black26,
          ),
          child: Text(
            '😤 Lazy peeps alert !',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
        content: Text(msg),
        titleTextStyle: Theme.of(context).textTheme.button.copyWith(
              fontSize: 16,
            ),
        contentTextStyle: Theme.of(context).textTheme.button,
        backgroundColor:
            Theme.of(context).buttonColor.withAlpha(230).withOpacity(1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
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

  void selectStartDate() async {
    var pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
      helpText: 'Pick day corresponding to the weekday',
    );
    setState(() {
      startDate = pickedDate;
    });
  }

  TextStyle labelTextStyle() {
    return TextStyle(
      color: Colors.white,
    );
  }

  // DropdownMenuItem _buildDropdownMenuItem(int weekDayIndex) {
  //   return DropdownMenuItem(
  //     child: Text(widget.weekDays[weekDayIndex]),
  //     value: widget.weekDays[weekDayIndex],
  //   );
  // }

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
          '$label Time 🥱 : ',
          style:
              labelTextStyle().copyWith(fontSize: 16, fontFamily: 'Comfortaa'),
        ),
        Text(
          '${time.format(context)} ',
          style: labelTextStyle().copyWith(fontFamily: 'Comfortaa'),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildTextField('Title', 40, true, titleController),
              _buildTextField('Description', 60, false, descriptionController),
              SizedBox(height: 20),
              Divider(),

              Align(
                child: Text(
                  'Select start date ⏰ :',
                  style: labelTextStyle().copyWith(
                      // color: Theme.of(context).textTheme.headline6.color,
                      fontSize: 16,
                      fontFamily: 'Comfortaa'),
                ),
                alignment: Alignment.centerLeft,
              ),
              Align(
                child: Text(
                  '(corresponding to the desired weekday)',
                  style: labelTextStyle().copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              Row(
                children: [
                  Text(
                    startDate == null
                        ? 'No date selected 😞'
                        : '${DateFormat.MMMMEEEEd().format(startDate)} 😊',
                    style: labelTextStyle()
                        .copyWith(color: Colors.blue, fontSize: 16),
                  ),
                  Spacer(),
                  OutlineButton(
                    child: Text('Pick Date'),
                    onPressed: selectStartDate,
                    textColor: Theme.of(context).textTheme.headline6.color,
                    highlightedBorderColor:
                        Theme.of(context).textTheme.headline6.color,
                  ),
                  // DropdownButton(
                  //   onChanged: (chosenWeekDay) {
                  //     setState(() {
                  //       selectedWeekDay = chosenWeekDay;
                  //     });
                  //     print('selected: $selectedWeekDay');
                  //   },
                  //   hint: Text('Pick a day...'),
                  //   value: selectedWeekDay,
                  //   style: labelTextStyle(),
                  //   items: [
                  //     _buildDropdownMenuItem(0),
                  //     _buildDropdownMenuItem(1),
                  //     _buildDropdownMenuItem(2),
                  //     _buildDropdownMenuItem(3),
                  //     _buildDropdownMenuItem(4),
                  //     _buildDropdownMenuItem(5),
                  //   ],
                  // ),
                ],
              ),
              Divider(),
              _buildSelectTimeRow('Start', startTime, selectStartTime),
              SizedBox(height: 20),
              // _buildSelectTimeRow('End', endTime, selectEndTime),
              RaisedButton(
                child: Text('Add Event'),
                color: Theme.of(context).textTheme.headline6.color,
                onPressed: validateAndAddEvent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

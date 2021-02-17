import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Event {
  String id;
  String title;
  String description;
  String weekDay;
  TimeOfDay startTime;
  TimeOfDay endTime;

  Event({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.weekDay,
    @required this.startTime,
    @required this.endTime,
  });
}

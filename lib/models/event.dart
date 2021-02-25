import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 0)
class Event {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String weekDay;
  @HiveField(4)
  DateTime startDate;
  @HiveField(5)
  TimeOfDay startTime;

  Event({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.weekDay,
    @required this.startDate,
    @required this.startTime,
  });
}

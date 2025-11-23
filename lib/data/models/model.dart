import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
enum RepeatInterval {
  @HiveField(0)
  once,
  @HiveField(1)
  weekly,
  @HiveField(2)
  monthly,
  @HiveField(3)
  daily,
}

@HiveType(typeId: 1)
enum ReminderType {
  @HiveField(0)
  work,
  @HiveField(1)
  personal,
  @HiveField(2)
  health,
  @HiveField(3)
  education,
}

@HiveType(typeId: 2)
enum NotificationStatus {
  @HiveField(0)
  confirm,
  @HiveField(1)
  snooze,
  @HiveField(2)
  cancel,
  @HiveField(4)
  pending,
}

@HiveType(typeId: 3)
class ReminderModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  TimeOfDay timeofday;

  @HiveField(3)
  RepeatInterval repeatInterval;

  @HiveField(4)
  ReminderType reminderType;

  @HiveField(5)
  int priority;

  @HiveField(6)
  NotificationStatus notificationStatus;

  @HiveField(7)
  String? imagePath;

  @HiveField(8)
  String? videoPath;
  @HiveField(9)
  List<String>? customDays;
  @HiveField(10)
  DateTime? dateTime;

  ReminderModel({
    required this.title,
    required this.description,
    required this.timeofday,
    required this.repeatInterval,
    required this.reminderType,
    required this.priority,
    required this.notificationStatus,
    this.imagePath,
    this.videoPath,
    this.customDays,
    this.dateTime,
  });
}

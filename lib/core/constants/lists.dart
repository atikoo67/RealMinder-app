import 'package:flutter/material.dart';
import 'package:realminder/data/models/model.dart';

class ConstantLists {
  static final remindertypes = ['Work', 'Personal', 'Health', 'Education'];
  static final List<String> repeatInterval = const [
    'Once',
    'Daily',
    'Weekly',
    "Monthly",
  ];
  static final List<String> days = const ['M', 'T', 'W', "Th", 'F', 'Sa', 'S'];
  static final Map<RepeatInterval, String> intervalrepeatenum = {
    RepeatInterval.once: 'Once',
    RepeatInterval.daily: 'Daily',
    RepeatInterval.weekly: 'Weekly',
    RepeatInterval.monthly: "Monthly",
  };

  static final Map<ReminderType, List> labelsenum = {
    ReminderType.work: ['Work', Icons.work],
    ReminderType.personal: ['Personal', Icons.person_add_alt],
    ReminderType.health: ['Health', Icons.medical_information],
    ReminderType.education: ['Education', Icons.school],
  };
}

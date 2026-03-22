import 'package:flutter/material.dart';

DateTime getNextScheduleDate(List<int> days, TimeOfDay time) {
  DateTime now = DateTime.now();

  for (int i = 0; i < 7; i++) {
    final date = now.add(Duration(days: i));

    if (days.contains(date.weekday)) {
      final target = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );

      if (target.isAfter(now)) {
        return target;
      }
    }
  }

  // Should not reach here normally
  return now.add(const Duration(days: 1));
}

DateTime getThirtyMinBefore(DateTime eventTime) {
  return eventTime.subtract(const Duration(minutes: 30));
}

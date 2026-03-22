// lib/services/schedule_manager.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    hide RepeatInterval;
import 'package:hive/hive.dart';
import 'package:realminder/core/utils/date_utils.dart';
import 'package:realminder/data/models/model.dart';
import 'package:timezone/timezone.dart' as tz;
// import your ReminderModel and enums

import 'notification_service.dart';

class ScheduleManager {
  final NotificationService notificationService;
  final Box<ReminderModel> box;

  int _normalizeWeekdayString(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return DateTime.monday; // 1
      case 'tuesday':
        return DateTime.tuesday; // 2
      case 'wednesday':
        return DateTime.wednesday; // 3
      case 'thursday':
        return DateTime.thursday; // 4
      case 'friday':
        return DateTime.friday; // 5
      case 'saturday':
        return DateTime.saturday; // 6
      case 'sunday':
        return DateTime.sunday; // 7
      default:
        return 0; // invalid
    }
  }

  DateTime _nextWeekdayAfter(
    int weekday,
    TimeOfDay timeOfDay,
    DateTime fromDate,
  ) {
    // Start with today's date and given time
    DateTime scheduled = DateTime(
      fromDate.year,
      fromDate.month,
      fromDate.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    // Calculate difference in weekdays
    int daysToAdd = (weekday - scheduled.weekday) % 7;
    if (daysToAdd == 0 && scheduled.isBefore(fromDate)) {
      // If today is the same weekday but time already passed, schedule for next week
      daysToAdd = 7;
    }

    scheduled = scheduled.add(Duration(days: daysToAdd));
    return scheduled;
  }

  /// How many future monthly occurrences to pre-schedule for monthly repeats.
  final int monthlyPreScheduleCount;

  ScheduleManager({
    required this.notificationService,
    required this.box,
    this.monthlyPreScheduleCount = 12,
  });

  /// Get stable integer id for a reminder and a slot (0 for 30-min-before, 1 for main, additional for monthly multiple)
  int _notificationIdFor(dynamic hiveKey, int slotIndex) {
    // If hiveKey is integer, use it; else convert to hashcode
    final base = (hiveKey is int) ? hiveKey : hiveKey.hashCode;
    // Combine base with slotIndex in a way unlikely to collide
    return base * 10 + slotIndex;
  }

  Future<void> scheduleAll() async {
    final now = DateTime.now();

    for (final rem in box.values) {
      final hiveKey = rem.key;
      if (hiveKey == null) {
        // reminder not yet saved with key — skip or save to get a key
        continue;
      }

      // Cancel any previously scheduled notifications for this reminder (simpler)
      // we assume slots 0..(1 + monthlyPreScheduleCount) may be used
      for (int s = 0; s < (2 + monthlyPreScheduleCount); s++) {
        await notificationService.cancel(_notificationIdFor(hiveKey, s));
      }

      // compute next trigger
      final next = getNextTriggerDate(
        repeat: rem.repeatInterval,
        timeOfDay: rem.timeofday,
        customDays: rem.customDays,
        baseDate: rem.dateTime,
      );

      // main notification id slot 1
      final mainId = _notificationIdFor(hiveKey, 1);
      // 30-min before id slot 0
      final beforeId = _notificationIdFor(hiveKey, 0);

      // Schedule the 30 minute before notification (if in future)
      final beforeTime = next.subtract(Duration(minutes: 30));
      if (beforeTime.isAfter(now)) {
        await notificationService.schedule(
          id: beforeId,
          title: "Upcoming: ${rem.title}",
          body: "${rem.description} — starts in 30 minutes",
          dateTime: beforeTime,
        );
      }

      // Schedule main reminder(s)
      switch (rem.repeatInterval) {
        case RepeatInterval.once:
          // one-off
          await notificationService.schedule(
            id: mainId,
            title: rem.title,
            body: rem.description,
            dateTime: next,
          );
          break;

        case RepeatInterval.daily:
          await notificationService.plugin.zonedSchedule(
            mainId,
            rem.title,
            rem.description,
            tz.TZDateTime.from(next, tz.local),
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'reminder_channel',
                'Reminders',
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.time,
            payload: jsonEncode({
              'key': rem.key,
              'title': rem.title,
              'description': rem.description,
              'repeatInterval': rem.repeatInterval.index,
              'reminderType': rem.reminderType.index,
              'priority': rem.priority,
              'imagepath': rem.imagePath,
              'videopath': rem.videoPath,
            }),
          );
          break;

        case RepeatInterval.weekly:
          final days = (rem.customDays ?? [])
              .map((s) => _normalizeWeekdayString(s))
              .where((d) => d >= 1 && d <= 7)
              .toList();

          if (days.isNotEmpty) {
            int slot = 1;
            for (final d in days) {
              final dt = _nextWeekdayAfter(d, rem.timeofday, DateTime.now());
              final id = _notificationIdFor(hiveKey, slot);
              await notificationService.plugin.zonedSchedule(
                id,
                rem.title,
                rem.description,
                tz.TZDateTime.from(dt, tz.local),
                const NotificationDetails(
                  android: AndroidNotificationDetails(
                    'reminder_channel',
                    'Reminders',
                    importance: Importance.max,
                    priority: Priority.high,
                  ),
                ),
                androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
                matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
                payload: 'reminder:$id',
              );
              slot++;
            }
          } else {
            // No customDays: schedule weekly based on baseDate weekday or nearest
            await notificationService.plugin.zonedSchedule(
              mainId,
              rem.title,
              rem.description,
              tz.TZDateTime.from(next, tz.local),
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  'reminder_channel',
                  'Reminders',
                  importance: Importance.max,
                  priority: Priority.high,
                ),
              ),
              androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
              matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
              payload: 'reminder:$mainId',
            );
          }
          break;

        case RepeatInterval.monthly:
          DateTime cursor = next;
          for (int i = 0; i < monthlyPreScheduleCount; i++) {
            final id = _notificationIdFor(hiveKey, 1 + i);
            await notificationService.schedule(
              id: id,
              title: rem.title,
              body: rem.description,
              dateTime: cursor,
            );
            // advance to next month same day
            final nextMonth = _advanceOneMonthKeepingDay(cursor);
            cursor = DateTime(
              nextMonth.year,
              nextMonth.month,
              nextMonth.day,
              rem.timeofday.hour,
              rem.timeofday.minute,
            );
          }
          break;
      }
    }
  }

  DateTime _advanceOneMonthKeepingDay(DateTime dt) {
    final desiredDay = dt.day;
    final nextMonth = dt.month + 1;
    final year = dt.year + ((nextMonth - 1) ~/ 12);
    final month = ((nextMonth - 1) % 12) + 1;
    final lastDay = DateTime(year, month + 1, 0).day;
    final day = desiredDay <= lastDay ? desiredDay : lastDay;
    return DateTime(
      year,
      month,
      day,
      dt.hour,
      dt.minute,
      dt.second,
      dt.millisecond,
      dt.microsecond,
    );
  }
}

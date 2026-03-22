import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:realminder/data/models/model.dart';
import 'package:realminder/logic/notification_service.dart';
import 'package:realminder/logic/permission.dart';
import 'package:realminder/logic/schedule_manager.dart';
import 'package:realminder/main.dart';

final notificationService = NotificationService(notificationsPlugin);

class ReminderRepository {
  final Box<ReminderModel> box = Hive.box<ReminderModel>('reminders');
  final alarmManager = AlarmPermissionManager(notificationsPlugin);

  Future<void> addReminder(ReminderModel reminder) async {
    await box.add(reminder);
    final manager = ScheduleManager(
      notificationService: notificationService,
      box: box,
    );
    final ok = await alarmManager.ensureExactAlarmPermission(
      notificationsPlugin,
    );

    if (!ok) {
      print("Exact alarm permission not granted.");
      return;
    }

    // schedule your notification here

    await manager.scheduleAll();
  }

  Future<void> updateReminder(int index, ReminderModel updated) async {
    await box.putAt(index, updated);
    final manager = ScheduleManager(
      notificationService: notificationService,
      box: box,
    );
    await manager.scheduleAll();
  }

  Future<void> deleteReminder(int index) async {
    await box.deleteAt(index);
    final manager = ScheduleManager(
      notificationService: notificationService,
      box: box,
    );

    // 1. Ensure permission
    final ok = await alarmManager.ensureExactAlarmPermission(
      notificationsPlugin,
    );

    if (!ok) {
      print("Exact alarm permission not granted.");
      return;
    }

    // schedule your notification here

    await manager.scheduleAll();
  }

  List<ReminderModel> getAll() => box.values.toList();

  ReminderModel getAt(int index) => box.getAt(index)!;

  int get length => box.length;
}

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return ReminderRepository();
});

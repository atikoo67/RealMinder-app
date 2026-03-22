// lib/services/notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin plugin;

  NotificationService(this.plugin);

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await plugin.initialize(settings);
  }

  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
    String? payload,
  }) async {
    final details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'reminder_channel',
        'Reminders',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      details,
      // NEW required param (choose appropriate mode)
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
      // NOTE: uiLocalNotificationDateInterpretation removed in latest versions
      // If you need repeating behaviour, pass matchDateTimeComponents below
    );
  }

  Future<void> scheduleRepeating({
    required int id,
    required String title,
    required String body,
    required DateTime firstDateTime,
    DateTimeComponents?
    matchDateTimeComponents, // e.g. DateTimeComponents.time or dayOfWeekAndTime
    String? payload,
  }) async {
    final details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'reminder_channel',
        'Reminders',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(firstDateTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
      matchDateTimeComponents: matchDateTimeComponents,
    );
  }

  Future<void> cancel(int id) => plugin.cancel(id);
  Future<void> cancelAll() => plugin.cancelAll();
}

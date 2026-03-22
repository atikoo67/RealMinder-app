import 'dart:convert';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    hide RepeatInterval;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/data/models/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:realminder/logic/notification_service.dart';
import 'package:realminder/logic/schedule_manager.dart';
import 'package:realminder/presentation/pages/alarmpopup.dart';
import 'package:realminder/presentation/pages/mainpage.dart';
import 'package:timezone/data/latest.dart' as tz;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(RepeatIntervalAdapter());
  Hive.registerAdapter(ReminderTypeAdapter());
  Hive.registerAdapter(NotificationStatusAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  await Hive.openBox<ReminderModel>('reminders');

  await AndroidAlarmManager.initialize();
  tz.initializeTimeZones();

  // Init notifications
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initSettings = InitializationSettings(android: android);
  await notificationsPlugin.initialize(initSettings);
  await notificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      final payload = response.payload;

      if (payload != null) {
        final Map<String, dynamic> data = jsonDecode(payload);

        final reminder = ReminderModel(
          title: data['title'],
          description: data['description'],
          timeofday: TimeOfDay(hour: data['hour'], minute: data['minute']),
          repeatInterval: RepeatInterval.values[data['repeatInterval']],
          reminderType: ReminderType.values[data['reminderType']],
          priority: data['priority'],
          notificationStatus: NotificationStatus.pending,
        );

        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (context) => AlarmPopup()),
        );
      }
    },
  );
  const MethodChannel rebootChannel = MethodChannel('schedule_rescheduler');
  rebootChannel.setMethodCallHandler((call) async {
    if (call.method == 'rescheduleAfterReboot') {
      final box = Hive.box<ReminderModel>('reminders');
      final manager = ScheduleManager(
        notificationService: NotificationService(notificationsPlugin),
        box: box,
      );
      await manager.scheduleAll();
    }
  });

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: theme,
    );
  }
}

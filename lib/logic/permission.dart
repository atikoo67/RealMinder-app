import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AlarmPermissionManager {
  final FlutterLocalNotificationsPlugin plugin;

  AlarmPermissionManager(this.plugin);

  /// Main function: ensures permission before scheduling any exact alarm.
  Future<bool> ensureExactAlarmPermission(
    FlutterLocalNotificationsPlugin plugin,
  ) async {
    final android = plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (android == null) return true; // iOS, Windows, web etc.

    // This returns true if permission is granted,
    // false if denied or cannot request.
    return await android.requestExactAlarmsPermission() ?? false;
  }

  /// Send user to settings where they must enable exact alarms manually.
  Future<void> openExactAlarmSettings() async {
    final androidPlugin = plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestExactAlarmsPermission(); // Opens OS screen
  }

  /// -----------------------------
  /// Internal helpers
  /// -----------------------------

  /// Returns Android SDK version (e.g. 34, 33, 31)
  Future<int> _getAndroidVersion() async {
    final info = await DeviceInfoPlugin().androidInfo;
    return info.version.sdkInt;
  }
}

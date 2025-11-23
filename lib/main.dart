import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/data/models/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:realminder/presentation/pages/mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(RepeatIntervalAdapter());
  Hive.registerAdapter(ReminderTypeAdapter());
  Hive.registerAdapter(NotificationStatusAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());

  await Hive.openBox<ReminderModel>('reminders');
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/presentation/providers/notifier.dart';
import 'package:realminder/presentation/widgets/remindercards.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final reminders = ref.watch(reminderProvider);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: theme.iconTheme.color,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Icon(Icons.alarm, color: Colors.white),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good morning,"),
                        Text(
                          "Atikoo",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: theme.colorScheme.secondary,
                  child: Image.asset('assets/profile.png'),
                ),
              ],
            ),
          ),
          Divider(thickness: 0.36),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Upcoming Reminders', style: theme.textTheme.titleLarge),
                  Expanded(
                    child: ListView.builder(
                      itemCount: reminders.length,
                      itemBuilder: (context, index) =>
                          ReminderCard(model: reminders[index], index: index),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

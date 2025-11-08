import 'package:flutter/material.dart';
import 'package:realminder/core/theme/theme.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(
          color: const Color.fromARGB(220, 0, 0, 0),
          width: 0.4,
        ),
      ),
      child: Row(
        spacing: 15,
        children: [
          Icon(Icons.lightbulb_outline_rounded, size: 25),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Morning Meditation',
                style: theme.textTheme.titleLarge!.copyWith(fontSize: 18),
              ),
              Row(
                spacing: 10,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 12,
                        color: theme.textTheme.titleSmall!.color,
                      ),
                      Text('3:00 AM', style: theme.textTheme.titleSmall),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.repeat,
                        size: 12,
                        color: theme.textTheme.titleSmall!.color,
                      ),
                      Text('Daily', style: theme.textTheme.titleSmall),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

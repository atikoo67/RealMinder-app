import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realminder/core/constants/lists.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/data/models/model.dart';
import 'package:realminder/presentation/providers/notifier.dart';

class ReminderCard extends ConsumerWidget {
  final ReminderModel model;
  final int index;
  const ReminderCard({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 20,
            children: [
              Icon(ConstantLists.labelsenum[model.reminderType]![1], size: 25),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
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
                          Text(
                            model.timeofday.format(context),
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.repeat,
                            size: 12,
                            color: theme.textTheme.titleSmall!.color,
                          ),
                          Text(
                            ConstantLists.intervalrepeatenum[model
                                .repeatInterval]!,
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              ref.read(reminderProvider.notifier).delete(index);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

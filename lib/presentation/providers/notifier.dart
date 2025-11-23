import 'package:hive_flutter/hive_flutter.dart';
import 'package:realminder/logic/reminderdatagetter/getreminder_fromhive.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realminder/data/models/model.dart';

class ReminderNotifier extends Notifier<List<ReminderModel>> {
  @override
  List<ReminderModel> build() {
    final repo = ref.read(reminderRepositoryProvider);

    // Listen to Hive changes
    repo.box.listenable().addListener(() {
      state = repo.getAll(); // refresh state on any Hive update
    });

    return repo.getAll();
  }

  Future<void> add(ReminderModel reminder) async {
    final repo = ref.read(reminderRepositoryProvider);
    await repo.addReminder(reminder);
  }

  Future<void> update(int index, ReminderModel updated) async {
    final repo = ref.read(reminderRepositoryProvider);
    await repo.updateReminder(index, updated);
  }

  Future<void> delete(int index) async {
    final repo = ref.read(reminderRepositoryProvider);
    await repo.deleteReminder(index);
  }
}

final reminderProvider =
    NotifierProvider<ReminderNotifier, List<ReminderModel>>(() {
      return ReminderNotifier();
    });

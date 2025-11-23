import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:realminder/data/models/model.dart';

class ReminderRepository {
  final Box<ReminderModel> box = Hive.box<ReminderModel>('reminders');

  Future<void> addReminder(ReminderModel reminder) async {
    await box.add(reminder);
  }

  Future<void> updateReminder(int index, ReminderModel updated) async {
    await box.putAt(index, updated);
  }

  Future<void> deleteReminder(int index) async {
    await box.deleteAt(index);
  }

  List<ReminderModel> getAll() => box.values.toList();

  ReminderModel getAt(int index) => box.getAt(index)!;

  int get length => box.length;
}

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return ReminderRepository();
});

// import 'package:hive/hive.dart';
// import 'recurrence_pattern.dart';
// import 'media_file.dart';

// part '../../reminderentity.g.dart';

// @HiveType(typeId: 0)
// class ReminderEntity extends HiveObject {
//   @HiveField(0)
//   late String id;

//   @HiveField(1)
//   late String title;

//   @HiveField(2)
//   late String description;

//   @HiveField(3)
//   late bool isActive;

//   @HiveField(4)
//   late RecurrencePattern recurrence;

//   @HiveField(5)
//   late List<MediaFile> mediaFiles;

//   @HiveField(6)
//   late DateTime dateTime;

//   @HiveField(7)
//   late DateTime nextTriggerDate;

//   @HiveField(8)
//   late bool isSnoozed;

//   @HiveField(9)
//   late DateTime? snoozedUntil;

// @HiveField(10)
//   late int snoozeCount;

//   ReminderEntity({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.dateTime,
//     this.isActive = true,
//     required this.recurrence,
//     this.mediaFiles = const [],
//     this.isSnoozed = false,
//     this.snoozedUntil,
//     this.snoozeCount = 0,
//   }) : nextTriggerDate = dateTime;
// }

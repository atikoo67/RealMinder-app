// import 'package:realminder/data/datasources/reminderentity.dart';
// import '../datasources/recurrence_pattern.dart';
// import '../datasources/media_file.dart';

// class Reminder {
//   final String id;
//   final String title;
//   final String description;
//   final DateTime dateTime;
//   final bool isActive;
//   final RecurrencePattern recurrence;
//   final List<MediaFile> mediaFiles;
//   final DateTime nextTriggerDate;
//   final bool isSnoozed;
//   final DateTime? snoozedUntil;
//   final int snoozeCount;

//   Reminder({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.dateTime,
//     required this.isActive,
//     required this.recurrence,
//     required this.mediaFiles,
//     required this.nextTriggerDate,
//     required this.isSnoozed,
//     required this.snoozedUntil,
//     required this.snoozeCount,
//   });

//   // Convert from Entity
//   factory Reminder.fromEntity(ReminderEntity entity) {
//     return Reminder(
//       id: entity.id,
//       title: entity.title,
//       description: entity.description,
//       dateTime: entity.dateTime,
//       isActive: entity.isActive,
//       recurrence: entity.recurrence,
//       mediaFiles: entity.mediaFiles,
//       nextTriggerDate: entity.nextTriggerDate,
//       isSnoozed: entity.isSnoozed,
//       snoozedUntil: entity.snoozedUntil,
//       snoozeCount: entity.snoozeCount,
//     );
//   }

//   // Convert to Entity
//   ReminderEntity toEntity() {
//     return ReminderEntity(
//       id: id,
//       title: title,
//       description: description,
//       dateTime: dateTime,
//       isActive: isActive,
//       recurrence: recurrence,
//       mediaFiles: mediaFiles,
//       isSnoozed: isSnoozed,
//       snoozedUntil: snoozedUntil,
//       snoozeCount: snoozeCount,
//     );
//   }

//   // Business logic methods
//   bool get shouldTriggerAlarm {
//     final now = DateTime.now();
//     return isActive &&
//         !isSnoozed &&
//         (now.isAfter(nextTriggerDate) || now.isAtSameMomentAs(nextTriggerDate));
//   }

//   bool get isRecurring => recurrence.type != RecurrenceType.none;

//   // Add more business methods as needed...
// }

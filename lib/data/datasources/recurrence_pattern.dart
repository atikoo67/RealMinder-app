// import 'package:hive/hive.dart';

// part '../../recurrence_pattern.g.dart';

// @HiveType(typeId: 1)
// enum RecurrenceType {
//   @HiveField(0)
//   none,

//   @HiveField(1)
//   daily,

//   @HiveField(2)
//   weekly,

//   @HiveField(3)
//   monthly,

//   @HiveField(4)
//   custom,
// }

// @HiveType(typeId: 2)
// class RecurrencePattern {
//   @HiveField(0)
//   final RecurrenceType type;

//   @HiveField(1)
//   final int interval;

//   @HiveField(2)
//   final List<int>? daysOfWeek;

//   @HiveField(3)
//   final DateTime? endDate;
// //
//   @HiveField(4)
//   final int? maxOccurrences;

//   RecurrencePattern({
//     required this.type,
//     this.interval = 1,
//     this.daysOfWeek,
//     this.endDate,
//     this.maxOccurrences,
//   });
// }

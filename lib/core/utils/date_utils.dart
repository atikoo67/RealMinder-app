// lib/utils/date_utils.dart
import 'package:flutter/material.dart';
import 'package:realminder/data/models/model.dart';

final Map<String, int> _weekdayMap = {
  'M': 1,

  'T': 2,

  'W': 3,

  'Th': 4,

  'F': 5,

  'Sa': 6,
  'S': 7,
};

int _normalizeWeekdayString(String s) {
  final key = s.trim().toLowerCase();
  return _weekdayMap[key] ?? -1;
}

DateTime _dayAtTime(DateTime day, TimeOfDay tod) {
  return DateTime(day.year, day.month, day.day, tod.hour, tod.minute);
}

/// Returns the next DateTime (strictly after `from`) for a given weekday (1..7)
DateTime _nextWeekdayAfter(int weekday, TimeOfDay tod, DateTime from) {
  // weekday: 1..7 (Mon..Sun)
  for (int offset = 0; offset < 7; offset++) {
    final candidate = from.add(Duration(days: offset));
    if (candidate.weekday == weekday) {
      final dt = _dayAtTime(candidate, tod);
      if (dt.isAfter(from)) return dt;
    }
  }
  // Fallback: return next week's same weekday
  final nextCandidate = from.add(Duration(days: 7));
  return _dayAtTime(nextCandidate, tod);
}

/// Returns the next occurrence (strictly after `from`) for monthly on day `dayOfMonth`.
/// If dayOfMonth doesn't exist in month, use last day of month.
DateTime _nextMonthlyDay(int dayOfMonth, TimeOfDay tod, DateTime from) {
  DateTime candidate;
  // Try this month
  int year = from.year;
  int month = from.month;

  DateTime dayInThisMonth = _dayForMonth(year, month, dayOfMonth, tod);
  if (dayInThisMonth.isAfter(from)) {
    return dayInThisMonth;
  }

  // Try next N months until find one (should find quickly)
  for (int i = 1; i <= 24; i++) {
    final m = month + i;
    final y = year + ((m - 1) ~/ 12);
    final mm = ((m - 1) % 12) + 1;
    candidate = _dayForMonth(y, mm, dayOfMonth, tod);
    if (candidate.isAfter(from)) return candidate;
  }

  // Fallback: tomorrow at time
  return _dayAtTime(from.add(Duration(days: 1)), tod);
}

DateTime _dayForMonth(int year, int month, int dayOfMonth, TimeOfDay tod) {
  final lastDay = DateTime(year, month + 1, 0).day; // last day of month
  final day = dayOfMonth <= lastDay ? dayOfMonth : lastDay;
  return DateTime(year, month, day, tod.hour, tod.minute);
}

/// Public API
///
/// - `customDays`: list of strings (weekday names or numbers) or null
/// - `baseDate`: use as reference for 'weekly' / 'monthly' to derive which weekday/day-of-month to use (optional)
DateTime getNextTriggerDate({
  required RepeatInterval repeat,
  required TimeOfDay timeOfDay,
  List<String>? customDays,
  DateTime? baseDate,
  DateTime? from,
}) {
  final now = from ?? DateTime.now();

  switch (repeat) {
    case RepeatInterval.once:
      // If baseDate provided, use its date+time if in the future; otherwise use today/time or tomorrow
      if (baseDate != null) {
        final candidate = DateTime(
          baseDate.year,
          baseDate.month,
          baseDate.day,
          timeOfDay.hour,
          timeOfDay.minute,
        );
        if (candidate.isAfter(now)) return candidate;
        // if baseDate in past, fallback to next daily occurrence from now
      }
      // choose next occurrence today at time or tomorrow
      final todayCandidate = DateTime(
        now.year,
        now.month,
        now.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );
      if (todayCandidate.isAfter(now)) return todayCandidate;
      return todayCandidate.add(Duration(days: 1));

    case RepeatInterval.daily:
      final todayCandidate = DateTime(
        now.year,
        now.month,
        now.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );
      if (todayCandidate.isAfter(now)) return todayCandidate;
      return todayCandidate.add(Duration(days: 1));

    case RepeatInterval.weekly:
      // If customDays provided, choose nearest weekday from list
      if (customDays != null && customDays.isNotEmpty) {
        // parse to integers
        final days = customDays
            .map(_normalizeWeekdayString)
            .where((d) => d >= 1 && d <= 7)
            .toList();
        if (days.isNotEmpty) {
          // find the soonest
          DateTime? best;
          for (final d in days) {
            final dt = _nextWeekdayAfter(d, timeOfDay, now);
            if (best == null || dt.isBefore(best)) best = dt;
          }
          return best!;
        }
      }

      // If baseDate provided (original scheduled date), use its weekday
      if (baseDate != null) {
        final weekday = baseDate.weekday;
        return _nextWeekdayAfter(weekday, timeOfDay, now);
      }

      // fallback: next weekday same as today
      return _nextWeekdayAfter(now.weekday, timeOfDay, now);

    case RepeatInterval.monthly:
      // If baseDate provided, use baseDate.day as day-of-month
      if (baseDate != null) {
        return _nextMonthlyDay(baseDate.day, timeOfDay, now);
      }

      // If customDays contains numeric day strings like "15", "01" prefer that
      if (customDays != null && customDays.isNotEmpty) {
        for (final c in customDays) {
          final trimmed = c.trim();
          final n = int.tryParse(trimmed);
          if (n != null && n >= 1 && n <= 31) {
            return _nextMonthlyDay(n, timeOfDay, now);
          }
        }
      }

      // fallback: use today's day-of-month
      return _nextMonthlyDay(now.day, timeOfDay, now);
  }
}

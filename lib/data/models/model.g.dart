// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderModelAdapter extends TypeAdapter<ReminderModel> {
  @override
  final int typeId = 3;

  @override
  ReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderModel(
      title: fields[0] as String,
      description: fields[1] as String,
      timeofday: fields[2] as TimeOfDay,
      repeatInterval: fields[3] as RepeatInterval,
      reminderType: fields[4] as ReminderType,
      priority: fields[5] as int,
      notificationStatus: fields[6] as NotificationStatus,
      imagePath: fields[7] as String?,
      videoPath: fields[8] as String?,
      customDays: (fields[9] as List?)?.cast<String>(),
      dateTime: fields[10] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.timeofday)
      ..writeByte(3)
      ..write(obj.repeatInterval)
      ..writeByte(4)
      ..write(obj.reminderType)
      ..writeByte(5)
      ..write(obj.priority)
      ..writeByte(6)
      ..write(obj.notificationStatus)
      ..writeByte(7)
      ..write(obj.imagePath)
      ..writeByte(8)
      ..write(obj.videoPath)
      ..writeByte(9)
      ..write(obj.customDays)
      ..writeByte(10)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RepeatIntervalAdapter extends TypeAdapter<RepeatInterval> {
  @override
  final int typeId = 0;

  @override
  RepeatInterval read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RepeatInterval.once;
      case 1:
        return RepeatInterval.weekly;
      case 2:
        return RepeatInterval.monthly;
      case 3:
        return RepeatInterval.daily;
      default:
        return RepeatInterval.once;
    }
  }

  @override
  void write(BinaryWriter writer, RepeatInterval obj) {
    switch (obj) {
      case RepeatInterval.once:
        writer.writeByte(0);
        break;
      case RepeatInterval.weekly:
        writer.writeByte(1);
        break;
      case RepeatInterval.monthly:
        writer.writeByte(2);
        break;
      case RepeatInterval.daily:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepeatIntervalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final int typeId = 4; // choose any unused ID

  @override
  TimeOfDay read(BinaryReader reader) {
    final hour = reader.readInt();
    final minute = reader.readInt();
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer.writeInt(obj.hour);
    writer.writeInt(obj.minute);
  }
}

class ReminderTypeAdapter extends TypeAdapter<ReminderType> {
  @override
  final int typeId = 1;

  @override
  ReminderType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReminderType.work;
      case 1:
        return ReminderType.personal;
      case 2:
        return ReminderType.health;
      case 3:
        return ReminderType.education;
      default:
        return ReminderType.work;
    }
  }

  @override
  void write(BinaryWriter writer, ReminderType obj) {
    switch (obj) {
      case ReminderType.work:
        writer.writeByte(0);
        break;
      case ReminderType.personal:
        writer.writeByte(1);
        break;
      case ReminderType.health:
        writer.writeByte(2);
        break;
      case ReminderType.education:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NotificationStatusAdapter extends TypeAdapter<NotificationStatus> {
  @override
  final int typeId = 2;

  @override
  NotificationStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NotificationStatus.confirm;
      case 1:
        return NotificationStatus.snooze;
      case 2:
        return NotificationStatus.cancel;
      case 4:
        return NotificationStatus.pending;
      default:
        return NotificationStatus.confirm;
    }
  }

  @override
  void write(BinaryWriter writer, NotificationStatus obj) {
    switch (obj) {
      case NotificationStatus.confirm:
        writer.writeByte(0);
        break;
      case NotificationStatus.snooze:
        writer.writeByte(1);
        break;
      case NotificationStatus.cancel:
        writer.writeByte(2);
        break;
      case NotificationStatus.pending:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

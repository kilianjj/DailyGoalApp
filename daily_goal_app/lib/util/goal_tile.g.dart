// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_tile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalAdapter extends TypeAdapter<Goal> {
  @override
  final int typeId = 0;

  @override
  Goal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Goal(
      task: fields[0] as String,
      lastComplete: fields[3] as DateTime,
      status: fields[4] as StreakStatus,
      frequency: fields[2] as RepeatFrequency,
      streak: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Goal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.streak)
      ..writeByte(2)
      ..write(obj.frequency)
      ..writeByte(3)
      ..write(obj.lastComplete)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RepeatFrequencyAdapter extends TypeAdapter<RepeatFrequency> {
  @override
  final int typeId = 1;

  @override
  RepeatFrequency read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RepeatFrequency.daily;
      case 1:
        return RepeatFrequency.weekly;
      case 2:
        return RepeatFrequency.monthly;
      case 3:
        return RepeatFrequency.yearly;
      default:
        return RepeatFrequency.daily;
    }
  }

  @override
  void write(BinaryWriter writer, RepeatFrequency obj) {
    switch (obj) {
      case RepeatFrequency.daily:
        writer.writeByte(0);
        break;
      case RepeatFrequency.weekly:
        writer.writeByte(1);
        break;
      case RepeatFrequency.monthly:
        writer.writeByte(2);
        break;
      case RepeatFrequency.yearly:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepeatFrequencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StreakStatusAdapter extends TypeAdapter<StreakStatus> {
  @override
  final int typeId = 2;

  @override
  StreakStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StreakStatus.completed;
      case 1:
        return StreakStatus.endingStreak;
      case 2:
        return StreakStatus.noStreak;
      default:
        return StreakStatus.completed;
    }
  }

  @override
  void write(BinaryWriter writer, StreakStatus obj) {
    switch (obj) {
      case StreakStatus.completed:
        writer.writeByte(0);
        break;
      case StreakStatus.endingStreak:
        writer.writeByte(1);
        break;
      case StreakStatus.noStreak:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreakStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

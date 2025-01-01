// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DeckModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeckModelAdapter extends TypeAdapter<DeckModel> {
  @override
  final int typeId = 0;

  @override
  DeckModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeckModel(
      name: fields[0] as String,
      card: (fields[1] as List).cast<CardModel>(),
      lastShowDate: fields[2] as DateTime?,
      nextShowDate: fields[3] as DateTime?,
      isStarted: fields[4] as bool,
      timesShown: fields[5] as int,
      isLearned: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DeckModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.card)
      ..writeByte(2)
      ..write(obj.lastShowDate)
      ..writeByte(3)
      ..write(obj.nextShowDate)
      ..writeByte(4)
      ..write(obj.isStarted)
      ..writeByte(5)
      ..write(obj.timesShown)
      ..writeByte(6)
      ..write(obj.isLearned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeckModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

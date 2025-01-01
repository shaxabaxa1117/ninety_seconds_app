// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CardModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardModelAdapter extends TypeAdapter<CardModel> {
  @override
  final int typeId = 1;

  @override
  CardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardModel(
      fields[0] as String?,
      fields[1] as String?,
      isFavourite: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, CardModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cardText)
      ..writeByte(1)
      ..write(obj.cardSubText)
      ..writeByte(2)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

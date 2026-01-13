// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommitAdapter extends TypeAdapter<Commit> {
  @override
  final int typeId = 1;

  @override
  Commit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Commit(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Commit obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

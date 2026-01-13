// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepoAdapter extends TypeAdapter<Repo> {
  @override
  final int typeId = 0;

  @override
  Repo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Repo(
      name: fields[0] as String,
      description: fields[1] as String,
      commits: (fields[2] as List).cast<Commit>(),
    );
  }

  @override
  void write(BinaryWriter writer, Repo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.commits);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

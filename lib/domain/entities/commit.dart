import 'package:hive/hive.dart';

part 'commit.g.dart';

@HiveType(typeId: 1)
class Commit {
  @HiveField(0)
  final String message;

  const Commit(this.message);
}

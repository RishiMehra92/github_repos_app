import 'package:hive/hive.dart';
import 'commit.dart';

part 'repo.g.dart';

@HiveType(typeId: 0)
class Repo {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final List<Commit> commits;

  const Repo({
    required this.name,
    required this.description,
    this.commits = const [],
  });

  Repo copyWith({List<Commit>? commits}) {
    return Repo(
      name: name,
      description: description,
      commits: commits ?? this.commits,
    );
  }
}

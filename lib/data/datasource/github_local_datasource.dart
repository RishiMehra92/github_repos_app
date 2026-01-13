import 'package:hive/hive.dart';
import '../../domain/entities/repo.dart';

class GithubLocalDatasource {
  static const boxName = 'repos';

  Future<List<Repo>> getRepos() async {
    final box = await Hive.openBox<Repo>(boxName);
    return box.values.toList();
  }

  Future<void> saveRepos(List<Repo> repos) async {
    final box = await Hive.openBox<Repo>(boxName);
    await box.clear();
    await box.addAll(repos);
  }
}

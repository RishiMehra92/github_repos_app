import '../../domain/entities/repo.dart';
import '../../domain/entities/commit.dart';
import '../../domain/repository/github_repository.dart';
import '../datasource/github_local_datasource.dart';
import '../datasource/github_remote_datasource.dart';

class GithubRepositoryImpl implements GithubRepository {
  final remote = GithubRemoteDatasource();
  final local = GithubLocalDatasource();

  @override
  Future<List<Repo>> getRepos() async {
    final cached = await local.getRepos();
    if (cached.isNotEmpty) return cached;

    final remoteRepos = (await remote.fetchRepos())
        .map((e) => e.toEntity())
        .toList();

    await local.saveRepos(remoteRepos);
    return remoteRepos;
  }

  @override
  Future<List<Commit>> getCommits(String repoName) async {
    final commits = await remote.fetchCommits(repoName);
    return commits.take(3).map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> syncRepos() async {
    final remoteRepos = (await remote.fetchRepos())
        .map((e) => e.toEntity())
        .toList();
    await local.saveRepos(remoteRepos);
  }
}

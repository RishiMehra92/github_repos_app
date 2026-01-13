import '../entities/repo.dart';
import '../entities/commit.dart';

abstract class GithubRepository {
  Future<List<Repo>> getRepos();
  Future<List<Commit>> getCommits(String repoName);
  Future<void> syncRepos();
}

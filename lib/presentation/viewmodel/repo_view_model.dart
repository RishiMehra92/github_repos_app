import 'package:flutter/material.dart';
import '../../domain/entities/repo.dart';
import '../../data/repository/github_repository_impl.dart';

class RepoViewModel extends ChangeNotifier {
  final _repo = GithubRepositoryImpl();

  List<Repo> repos = [];
  bool loading = true;

  Future<void> load() async {
    repos = await _repo.getRepos();
    loading = false;
    notifyListeners();
    await _repo.syncRepos();
  }

  Future<void> loadCommitsIfNeeded(int index) async {
    if (index < 0 || index >= repos.length) return;

    final repo = repos[index];

    if (repo.commits.isNotEmpty) return;

    try {
      final commits = await _repo.getCommits(repo.name);

      repos[index] = repo.copyWith(commits: commits);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load commits for ${repo.name}: $e');
    }
  }
}

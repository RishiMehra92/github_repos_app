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

  Future<void> loadCommits(int index) async {
    if (repos[index].commits.isNotEmpty) return;

    final commits =
        await _repo.getCommits(repos[index].name);

    repos[index] = repos[index].copyWith(commits: commits);
    notifyListeners();
  }
}

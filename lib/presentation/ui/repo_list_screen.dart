import 'package:flutter/material.dart';
import 'package:github_repos_app/presentation/ui/view/top_repo_carousel.dart';
import '../viewmodel/repo_view_model.dart';
import 'view/repo_card.dart';
import 'repo_detail_sheet.dart';
import 'view/ui_constants.dart';

class RepoListScreen extends StatefulWidget {
  const RepoListScreen({super.key});

  @override
  State<RepoListScreen> createState() => _RepoListScreenState();
}

class _RepoListScreenState extends State<RepoListScreen> {
  final vm = RepoViewModel();

  @override
  void initState() {
    super.initState();
    vm.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UI.bgColor,
      appBar: AppBar(
        title: const Text('GITHUB'),
        backgroundColor: UI.bgColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: vm,
        builder: (_, __) {
          if (vm.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final topRepos = vm.repos.length > 5
              ? vm.repos.take(5).toList()
              : vm.repos;

          final int remainingReposCount = vm.repos.length > 5
              ? vm.repos.length - 5
              : 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopRepoCarousel(repos: topRepos, viewModel: vm),

              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Git Repo',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: remainingReposCount,
                  itemBuilder: (_, i) {
                    final repoIndex = i + 5;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      vm.loadCommitsIfNeeded(repoIndex);
                    });

                    return RepoCard(
                      repo: vm.repos[repoIndex],
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                        ),
                        builder: (_) =>
                            RepoDetailSheet(repo: vm.repos[repoIndex]),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

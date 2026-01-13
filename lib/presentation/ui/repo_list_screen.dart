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
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: vm,
        builder: (_, __) {
          if (vm.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopRepoCarousel(repos: vm.repos),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text('Git Repo',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: vm.repos.length,
                  itemBuilder: (_, i) {
                    vm.loadCommits(i);

                    return RepoCard(
                      repo: vm.repos[i],
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(18)),
                        ),
                        builder: (_) =>
                            RepoDetailSheet(repo: vm.repos[i]),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

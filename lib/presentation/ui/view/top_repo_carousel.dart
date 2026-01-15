import 'package:flutter/material.dart';
import '../../../domain/entities/repo.dart';
import '../../viewmodel/repo_view_model.dart';
import '../repo_detail_sheet.dart';
import 'ui_constants.dart';

class TopRepoCarousel extends StatefulWidget {
  final List<Repo> repos;
  final RepoViewModel viewModel;

  const TopRepoCarousel({
    super.key,
    required this.repos,
    required this.viewModel,
  });

  @override
  State<TopRepoCarousel> createState() => _TopRepoCarouselState();
}

class _TopRepoCarouselState extends State<TopRepoCarousel> {
  static const int _virtualItemCount = 10000;

  late final PageController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    final initialPage =
        (_virtualItemCount ~/ 2) -
        ((_virtualItemCount ~/ 2) % widget.repos.length);

    _controller = PageController(
      viewportFraction: 0.85,
      initialPage: initialPage,
    );

    _currentIndex = initialPage % widget.repos.length;
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.repos;
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 100,
          child: PageView.builder(
            controller: _controller,
            itemCount: _virtualItemCount,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index % items.length;
              });
            },
            itemBuilder: (_, index) {
              final repo = items[index % items.length];

              return GestureDetector(
                onTap: () async {
                  final repoIndex = widget.viewModel.repos.indexWhere(
                    (r) => r.name == repo.name,
                  );

                  if (repoIndex != -1) {
                    widget.viewModel.loadCommitsIfNeeded(repoIndex);
                  }

                  if (!context.mounted) return;

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                    ),
                    builder: (_) {
                      return AnimatedBuilder(
                        animation: widget.viewModel,
                        builder: (_, __) {
                          final updatedRepo = widget.viewModel.repos[repoIndex];

                          return RepoDetailSheet(repo: updatedRepo);
                        },
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: UI.cardColor,
                    borderRadius: UI.cardRadius,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.book, size: 36),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          repo.name,
                          style: UI.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: _currentIndex == i ? 18 : 6,
              decoration: BoxDecoration(
                color: _currentIndex == i ? Colors.black : Colors.black26,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

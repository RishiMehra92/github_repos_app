import 'package:flutter/material.dart';
import '../../../domain/entities/repo.dart';
import '../repo_detail_sheet.dart';
import 'ui_constants.dart';

class TopRepoCarousel extends StatefulWidget {
  final List<Repo> repos;

  const TopRepoCarousel({super.key, required this.repos});

  @override
  State<TopRepoCarousel> createState() => _TopRepoCarouselState();
}

class _TopRepoCarouselState extends State<TopRepoCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.85);

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final items = widget.repos.take(5).toList();

    return Column(
      children: [
        SizedBox(
          height: 100,
          child: PageView.builder(
            controller: _controller,
            itemCount: items.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (_, i) {
              return GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(18)),
                  ),
                  builder: (_) =>
                      RepoDetailSheet(repo: items[i]),
                ),
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
                          items[i].name,
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

        /// 🔴 SLIDER DOTS
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
}

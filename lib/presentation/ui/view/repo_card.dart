import 'package:flutter/material.dart';
import '../../../domain/entities/repo.dart';
import 'ui_constants.dart';

class RepoCard extends StatefulWidget {
  final Repo repo;
  final VoidCallback onTap;

  const RepoCard({
    super.key,
    required this.repo,
    required this.onTap,
  });

  @override
  State<RepoCard> createState() => _RepoCardState();
}

class _RepoCardState extends State<RepoCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final hasCommits = widget.repo.commits.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: UI.cardColor,
        borderRadius: UI.cardRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               GestureDetector(
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                child: const _Logo(),
              ),

              const SizedBox(width: 12),

               Flexible(
                child: InkWell(
                  onTap: widget.onTap,
                  child: Text(
                    widget.repo.name,
                    style: UI.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),

           if (_expanded && hasCommits) ...[
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.repo.commits.take(3).map((commit) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    commit.message,
                    style: UI.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/git.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

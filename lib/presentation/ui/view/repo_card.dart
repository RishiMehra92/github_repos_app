import 'package:flutter/material.dart';
import '../../../domain/entities/repo.dart';
import 'ui_constants.dart';

class RepoCard extends StatelessWidget {
  final Repo repo;
  final VoidCallback onTap;

  const RepoCard({
    super.key,
    required this.repo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: UI.cardColor,
          borderRadius: UI.cardRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            _Logo(),
            const SizedBox(width: 12),
            Expanded(
              child: Text(repo.name, style: UI.title),
            ),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
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

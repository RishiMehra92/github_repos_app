import 'package:flutter/material.dart';
import '../../domain/entities/repo.dart';
import 'view/ui_constants.dart';

class RepoDetailSheet extends StatelessWidget {
  final Repo repo;

  const RepoDetailSheet({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    repo.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: UI.cardColor,
                borderRadius: UI.cardRadius,
                image: const DecorationImage(
                  image: AssetImage('assets/github.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Description: ${repo.description}', style: UI.subtitle),
            const SizedBox(height: 16),
            ...repo.commits.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(e.message, style: UI.subtitle),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

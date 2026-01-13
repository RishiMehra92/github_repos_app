import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'domain/entities/repo.dart';
import 'domain/entities/commit.dart';
import 'presentation/ui/repo_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(RepoAdapter());
  Hive.registerAdapter(CommitAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepoListScreen(),
    );
  }
}

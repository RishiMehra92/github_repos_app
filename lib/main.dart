import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'domain/entities/repo.dart';
import 'domain/entities/commit.dart';
import 'presentation/ui/repo_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  debugPrint('ENV loaded: ${dotenv.env}');

  await Hive.initFlutter();

  Hive.registerAdapter(RepoAdapter());
  Hive.registerAdapter(CommitAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const RepoListScreen(),
    );
  }
}

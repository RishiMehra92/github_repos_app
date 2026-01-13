import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/repo_dto.dart';
import '../models/commit_dto.dart';

class GithubRemoteDatasource {
  static const _base = 'https://api.github.com/users/mralexgray';

  Future<List<RepoDto>> fetchRepos() async {
    final res = await http.get(Uri.parse('$_base/repos'));
    final List data = jsonDecode(res.body);
    return data.map((e) => RepoDto.fromJson(e)).toList();
  }

  Future<List<CommitDto>> fetchCommits(String repo) async {
    final res =
        await http.get(Uri.parse('$_base/$repo/commits'));
    final List data = jsonDecode(res.body);
    return data.map((e) => CommitDto.fromJson(e)).toList();
  }
}

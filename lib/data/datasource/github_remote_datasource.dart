import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/repo_dto.dart';
import '../models/commit_dto.dart';
import '../network/dio_client.dart';

class GithubRemoteDatasource {
  final Dio _dio = DioClient().dio;
  final String username = dotenv.env['GITHUB_USERNAME']!;

  Future<List<RepoDto>> fetchRepos() async {
    debugPrint('Using GitHub user: ${dotenv.env['GITHUB_USERNAME']}');

    final url = '/users/$username/repos';

    debugPrint('Fetching repos from: $url');

    final Response res = await _dio.get(url);
    if (res.data is! List) {
      return [];
    }

    final List list = res.data as List;

    return list.map((e) => RepoDto.fromJson(e)).toList();
  }

  Future<List<CommitDto>> fetchCommits(String repo) async {
    final url = '/repos/$username/$repo/commits';

    debugPrint('Fetching commits from: $url');

    try {
      final Response res = await _dio.get(url);

      debugPrint('Status Code: ${res.statusCode}');

      if (res.statusCode == 409) {
        debugPrint('Repo "$repo" has no commits yet.');
        return [];
      }

      if (res.data is! List) {
        debugPrint('Unexpected response for "$repo": ${res.data}');
        return [];
      }

      return (res.data as List).map((e) => CommitDto.fromJson(e)).toList();
    } on DioException catch (e) {
      debugPrint('Dio error while fetching commits for $repo');
      debugPrint('Message: ${e.message}');
      debugPrint('Response: ${e.response?.data}');
      return [];
    } catch (e) {
      debugPrint('Unknown error while fetching commits for $repo');
      debugPrint(e.toString());
      return [];
    }
  }
}

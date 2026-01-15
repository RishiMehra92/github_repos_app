import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    final baseUrl = dotenv.env['GITHUB_BASE_URL']!;
    final token = dotenv.env['GITHUB_TOKEN'];

    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        validateStatus: (status) {
          return status != null && status < 500;
        },
        headers: {
          'Accept': 'application/vnd.github+json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: false,
        responseBody: true,
        responseHeader: false,
      ),
    );
  }
}

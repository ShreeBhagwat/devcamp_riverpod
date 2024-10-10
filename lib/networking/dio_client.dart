import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_1/networking/api_endpoints.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options
      ..baseUrl = ApiEndpoints.BaseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..headers = {
        'Content-Type': 'application/json',
      };
  }

  Future<Response> get(String endPoint,
      {Map<String, dynamic>? queryParameter}) async {
    try {
      return await _dio.get(endPoint, queryParameters: queryParameter);
    } catch (e) {
      rethrow;
    }
  }
}

final dioProvider = Provider<DioClient>((ref) => DioClient());

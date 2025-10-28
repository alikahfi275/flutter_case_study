import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  final Dio _dio;

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: "https://api.restful-api.dev",
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print(
            "[DIO - INTERCEPTOR - REQUEST] ${options.method} ${options.uri}",
          );
          return handler.next(options);
        },
        onResponse: (response, handler) {
          const encoder = JsonEncoder.withIndent('  ');
          final pretty = encoder.convert(response.data);

          print(
            '[DIO - INTERCEPTOR - RESPONSE] ${response.statusCode}:\n$pretty',
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.response != null) {
            const encoder = JsonEncoder.withIndent('  ');
            final pretty = encoder.convert(e.response?.data);
            print(
              '[DIO - INTERCEPTOR - ERROR] ${e.response?.statusCode}:\n$pretty',
            );
          } else {
            print('[DIO - INTERCEPTOR - ERROR] ${e.message}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<dynamic> get(String path) async {
    final res = await _dio.get(path);
    return res.data;
  }

  Future<dynamic> post(String path, Map<String, dynamic> data) async {
    final res = await _dio.post(path, data: data);
    return res.data;
  }

  Future<dynamic> put(String path, Map<String, dynamic> data) async {
    final res = await _dio.put(path, data: data);
    return res.data;
  }

  Future<dynamic> delete(String path) async {
    final res = await _dio.delete(path);
    return res.data;
  }
}

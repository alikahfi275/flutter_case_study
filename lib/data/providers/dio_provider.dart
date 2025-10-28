import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.restful-api.dev', // ganti sesuai API kamu
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        print("[DIO INTERCEPTOR REQUEST] ${options.method} ${options.uri}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print(
          "[DIO INTERCEPTOR RESPONSE] ${response.statusCode} ${response.data}",
        );
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print("[DIO INTERCEPTOR ERROR] ${e.response?.statusCode} ${e.message}");
        return handler.next(e);
      },
    ),
  );

  return dio;
});

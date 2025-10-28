import 'package:dio/dio.dart';

class ApiService {
  late Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://example.com/api",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Tambah Authorization token jika ada
          final token = ""; // nanti ambil dari storage
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          print("[REQUEST] ${options.method} ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("[RESPONSE] ${response.statusCode} ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("[ERROR] ${e.response?.statusCode} ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }
}

// core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static Dio? _instance;

  static Dio get instance {
    if (_instance == null) {
      throw Exception(
        "DioClient not initialized. Call DioClient.initialize(baseUrl) first.",
      );
    }
    return _instance!;
  }

  static void initialize(String baseUrl) {
    final cleanedUrl = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';

    _instance = Dio(
      BaseOptions(
        baseUrl: cleanedUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );

    if (kDebugMode) {
      _instance!.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  static void reset() {
    _instance = null;
  }
}

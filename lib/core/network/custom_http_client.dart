// core/network/custom_http_client.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../di/injection_container.dart' as di;
import '../../core/repositories/app_settings_repository.dart';

class CustomHttpClient {
  static String? _baseUrl;

  // Private constructor
  CustomHttpClient._();

  // Load base URL if not already set
  static Future<void> _ensureBaseUrl() async {
    if (_baseUrl != null) return; // Already set

    final repo = di.sl<AppSettingsRepository>();
    final result = await repo.getBaseUrl();

    final url = result.getOrElse(() => null);
    if (url != null && url.isNotEmpty) {
      _baseUrl = url;
      if (kDebugMode) {
        print("🔵 Lazy-loaded base URL: $_baseUrl");
      }
    }
  }

  // Public method to get Dio instance
  static Future<Dio> dio() async {
    await _ensureBaseUrl();

    if (_baseUrl == null) {
      throw Exception("No site URL configured. Please set up the app first.");
    }

    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl!,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    return dio;
  }

  // Manual set (used in ConfigurationPage after save)
  static void setBaseUrl(String url) {
    _baseUrl = url.trim();
    if (!_baseUrl!.endsWith('/')) _baseUrl = '$_baseUrl/';
    if (kDebugMode) {
      print("🔵 Base URL manually set: $_baseUrl");
    }
  }

  // Clear for reconfiguration
  static void clear() {
    _baseUrl = null;
  }
}

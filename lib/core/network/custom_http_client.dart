import 'package:dio/dio.dart';

const local =
    'http://localhost/wp-sellsheba/wp-json/sellsheba-connect/'; // Use 10.0.2.2 for Android Emulator
const production = 'https://coachingsheba.com/api/';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: local,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(LogInterceptor(responseBody: true)); // Debug logs
    return dio;
  }
}

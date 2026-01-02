// features/auth/data/datasources/auth_remote_data_source.dart

import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/custom_http_client.dart' show CustomHttpClient;
import '../../domain/entities/auth_entity.dart'; // or your model
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<AuthModel> login(String username, String password) async {
    final dio = await CustomHttpClient.dio(); // Now async

    try {
      final response = await dio.post(
        'wp-json/jwt-auth/v1/token', // Standard JWT Auth plugin endpoint
        data: {'username': username, 'password': password},
      );

      print(response);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        return AuthModel.fromJson(data);
      } else {
        throw ServerFailure(
          message: response.data['message'] ?? 'Login failed',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final message = e.response?.data['message'] ?? 'Invalid credentials';
        throw ServerFailure(message: message);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkFailure(
          message: 'Connection timeout. Check your internet.',
        );
      } else {
        throw NetworkFailure(message: 'No internet connection');
      }
    } catch (e) {
      throw ServerFailure(message: 'Unexpected error during login');
    }
  }
}

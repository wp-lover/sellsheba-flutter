import 'package:dio/dio.dart';
import '../../data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthModel> login(String username, String password) async {
    // TODO: Connect to Real JWT Auth Endpoint
    await Future.delayed(const Duration(seconds: 1));

    // Mock Response
    if (username == 'admin' && password == 'admin') {
      return const AuthModel(
        token: 'dummy_jwt_token_xyz',
        userId: 1,
        userDisplayName: 'Sellsheba Admin',
        userRole: 'administrator',
      );
    } else {
      throw Exception("Invalid Credentials");
    }
  }
}

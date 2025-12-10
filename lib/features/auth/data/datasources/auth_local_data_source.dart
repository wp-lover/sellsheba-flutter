import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/auth_model.dart';
import '../../domain/entities/auth_entity.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  Future<void> saveAuth(AuthModel auth);
  Future<AuthModel?> getAuth();
  Future<void> clearAuth();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String cachedAuthKey = 'CACHED_AUTH_USER';

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveAuth(AuthModel auth) async {
    final jsonString = jsonEncode(auth.toJson());
    await secureStorage.write(key: cachedAuthKey, value: jsonString);
  }

  @override
  Future<AuthModel?> getAuth() async {
    final jsonString = await secureStorage.read(key: cachedAuthKey);
    if (jsonString != null) {
      try {
        return AuthModel.fromJson(jsonDecode(jsonString));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> clearAuth() async {
    await secureStorage.delete(key: cachedAuthKey);
  }
}

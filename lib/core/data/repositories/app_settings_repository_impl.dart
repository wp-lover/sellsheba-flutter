// lib/core/data/repositories/app_settings_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/storage_keys.dart';
import '../../error/failures.dart';
import '../../repositories/app_settings_repository.dart';

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  AppSettingsRepositoryImpl({
    required this.secureStorage,
    required this.sharedPreferences,
  });

  String _normalizeUrl(String url) {
    String cleaned = url.trim();
    if (!cleaned.startsWith('http://') && !cleaned.startsWith('https://')) {
      cleaned = 'https://$cleaned';
    }
    if (!cleaned.endsWith('/')) cleaned += '/';
    return cleaned;
  }

  @override
  Future<Either<Failure, String?>> getBaseUrl() async {
    try {
      final url = await secureStorage.read(key: StorageKeys.baseUrl);
      return Right(url);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveBaseUrl(String url) async {
    try {
      final normalized = _normalizeUrl(url);
      await secureStorage.write(key: StorageKeys.baseUrl, value: normalized);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getJwtToken() async {
    try {
      final token = await secureStorage.read(key: StorageKeys.jwtToken);
      return Right(token);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveJwtToken(String token) async {
    try {
      await secureStorage.write(key: StorageKeys.jwtToken, value: token);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> clearJwtToken() async {
    try {
      await secureStorage.delete(key: StorageKeys.jwtToken);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isConfigured() async {
    final result = await getBaseUrl();
    return result.fold(
      (f) => Left(f),
      (url) => Right(url != null && url.isNotEmpty),
    );
  }

  @override
  Future<Either<Failure, Unit>> clearAll() async {
    try {
      await secureStorage.deleteAll();
      await sharedPreferences.clear();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

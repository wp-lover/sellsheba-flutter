// features/configuration/data/repositories/configuration_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/app_configuration.dart';
import '../../domain/repositories/configuration_repository.dart';

class ConfigurationRepositoryImpl implements ConfigurationRepository {
  final FlutterSecureStorage secureStorage;
  static const String _key = 'app_base_url';

  ConfigurationRepositoryImpl({required this.secureStorage});

  @override
  Future<Either<Failure, AppConfiguration?>> getSavedConfiguration() async {
    try {
      final url = await secureStorage.read(key: _key);
      if (url == null || url.isEmpty) {
        return const Right(null);
      }
      return Right(AppConfiguration(baseUrl: url));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveConfiguration(
    AppConfiguration config,
  ) async {
    try {
      await secureStorage.write(key: _key, value: config.baseUrl);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> clearConfiguration() async {
    try {
      await secureStorage.delete(key: _key);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

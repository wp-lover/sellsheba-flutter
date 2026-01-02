// lib/core/repositories/app_settings_repository.dart

import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class AppSettingsRepository {
  Future<Either<Failure, String?>> getBaseUrl();
  Future<Either<Failure, Unit>> saveBaseUrl(String url);

  Future<Either<Failure, String?>> getJwtToken();
  Future<Either<Failure, Unit>> saveJwtToken(String token);
  Future<Either<Failure, Unit>> clearJwtToken();

  Future<Either<Failure, bool>> isConfigured();

  Future<Either<Failure, Unit>> clearAll(); // For full reset
}

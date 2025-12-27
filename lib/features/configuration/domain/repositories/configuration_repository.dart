// features/configuration/domain/repositories/configuration_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/app_configuration.dart';

abstract class ConfigurationRepository {
  Future<Either<Failure, AppConfiguration?>> getSavedConfiguration();
  Future<Either<Failure, Unit>> saveConfiguration(AppConfiguration config);
  Future<Either<Failure, Unit>> clearConfiguration();
}

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/configuration_entity.dart';

abstract class ConfigurationRepository {
  Future<Either<Failure, bool>> verifyAndSave({
    required String siteUrl,
    required String licenseKey,
  });

  Future<Either<Failure, ConfigurationEntity?>> getConfiguration();

  Future<Either<Failure, void>> clearConfiguration();
}

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/configuration_entity.dart';
import '../../domain/repositories/configuration_repository.dart';
import '../datasources/configuration_local_data_source.dart';
import '../datasources/configuration_remote_data_source.dart';
import '../models/configuration_model.dart';

class ConfigurationRepositoryImpl implements ConfigurationRepository {
  final ConfigurationRemoteDataSource remoteDataSource;
  final ConfigurationLocalDataSource localDataSource;

  ConfigurationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, bool>> verifyAndSave({
    required String siteUrl,
    required String licenseKey,
  }) async {
    try {
      final isValid = await remoteDataSource.verifyLicense(siteUrl, licenseKey);
      if (isValid) {
        final configModel = ConfigurationModel(
          siteUrl: siteUrl,
          licenseKey: licenseKey,
        );
        await localDataSource.saveConfiguration(configModel);
        return const Right(true);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ConfigurationEntity?>> getConfiguration() async {
    try {
      final config = await localDataSource.getConfiguration();
      return Right(config);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> clearConfiguration() async {
    try {
      await localDataSource.clearConfiguration();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

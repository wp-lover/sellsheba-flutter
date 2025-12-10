import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String username,
    required String password,
  }) async {
    try {
      final authModel = await remoteDataSource.login(username, password);
      await localDataSource.saveAuth(authModel);
      return Right(authModel);
    } catch (e) {
      return const Left(ServerFailure(message: 'Invalid Credentials'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearAuth();
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, AuthEntity?>> getAuthStatus() async {
    try {
      final authModel = await localDataSource.getAuth();
      return Right(authModel);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }
}

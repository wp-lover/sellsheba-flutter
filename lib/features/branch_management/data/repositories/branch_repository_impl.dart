import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/branch_entity.dart';
import '../../domain/repositories/branch_repository.dart';
import '../datasources/branch_remote_data_source.dart';

class BranchRepositoryImpl implements BranchRepository {
  final BranchRemoteDataSource remoteDataSource;

  BranchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BranchEntity>>> getBranches() async {
    try {
      final branches = await remoteDataSource.getBranches();
      return Right(branches);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> selectBranch(BranchEntity branch) async {
    // For now, selecting a branch is just a local state confirmation
    // In future, might need to tell backend "I am entering this branch context"
    return const Right(null);
  }
}

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/branch_entity.dart';

abstract class BranchRepository {
  Future<Either<Failure, List<BranchEntity>>> getBranches();

  // In a real app, selecting a branch might involve an API call to set session context
  // or just local storage. We'll verify it returns void/success
  Future<Either<Failure, void>> selectBranch(BranchEntity branch);
}

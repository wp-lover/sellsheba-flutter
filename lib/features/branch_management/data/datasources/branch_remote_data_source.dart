import 'package:dio/dio.dart';
import '../models/branch_model.dart';

abstract class BranchRemoteDataSource {
  Future<List<BranchModel>> getBranches();
}

class BranchRemoteDataSourceImpl implements BranchRemoteDataSource {
  final Dio client;

  BranchRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BranchModel>> getBranches() async {
    // TODO: Connect to real API
    // Simulate delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy Data
    return const [
      BranchModel(
        id: 1,
        name: 'Dhaka Main Branch',
        address: '123 Gulshan Ave, Dhaka',
      ),
      BranchModel(
        id: 2,
        name: 'Chittagong Port Branch',
        address: '45 Agrabad, Chittagong',
      ),
      BranchModel(
        id: 3,
        name: 'Sylhet Garden Branch',
        address: '89 Zinda Bazar, Sylhet',
      ),
    ];
  }
}

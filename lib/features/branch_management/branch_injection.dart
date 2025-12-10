import 'package:get_it/get_it.dart';
import 'data/datasources/branch_remote_data_source.dart';
import 'data/repositories/branch_repository_impl.dart';
import 'domain/repositories/branch_repository.dart';
import 'presentation/bloc/branch_bloc.dart';

Future<void> initBranchManagement() async {
  final sl = GetIt.instance;

  // Bloc
  sl.registerFactory(() => BranchBloc(repository: sl()));

  // Repository
  sl.registerLazySingleton<BranchRepository>(
    () => BranchRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<BranchRemoteDataSource>(
    () => BranchRemoteDataSourceImpl(client: sl()),
  );
}

import 'package:get_it/get_it.dart';

import 'data/datasources/configuration_local_data_source.dart';
import 'data/datasources/configuration_remote_data_source.dart';
import 'data/repositories/configuration_repository_impl.dart';
import 'domain/repositories/configuration_repository.dart';
import 'presentation/bloc/configuration_bloc.dart';

Future<void> initConfiguration() async {
  final sl = GetIt.instance;

  // Bloc
  sl.registerFactory(() => ConfigurationBloc(repository: sl()));

  // Repository
  sl.registerLazySingleton<ConfigurationRepository>(
    () => ConfigurationRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ConfigurationRemoteDataSource>(
    () => ConfigurationRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<ConfigurationLocalDataSource>(
    () => ConfigurationLocalDataSourceImpl(
      secureStorage: sl(),
      sharedPreferences: sl(),
    ),
  );
}

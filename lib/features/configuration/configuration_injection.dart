import 'package:sellsheba/core/di/injection_container.dart';

import 'data/repositories/configuration_repository_impl.dart';
import 'domain/repositories/configuration_repository.dart';
import 'presentation/bloc/configuration_bloc.dart';

Future<void> initConfiguration() async {
  sl.registerLazySingleton<ConfigurationRepository>(
    () => ConfigurationRepositoryImpl(secureStorage: sl()),
  );

  sl.registerFactory(() => ConfigurationBloc(repository: sl()));
}

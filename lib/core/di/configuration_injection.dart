// core/di/configuration_injection.dart

import '../../features/configuration/presentation/bloc/configuration_bloc.dart';

import '../repositories/app_settings_repository.dart'
    show AppSettingsRepository;
import 'injection_container.dart'; // core repo

Future<void> initConfiguration() async {
  sl.registerFactory(
    () => ConfigurationBloc(appSettingsRepo: sl<AppSettingsRepository>()),
  );
}

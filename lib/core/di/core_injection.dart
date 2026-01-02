// core/di/core_injection.dart

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sellsheba/core/di/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repositories/app_settings_repository_impl.dart'
    show AppSettingsRepositoryImpl;
import '../repositories/app_settings_repository.dart'
    show AppSettingsRepository;

Future<void> initCore() async {
  // External
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);

  sl.registerLazySingleton(() => const FlutterSecureStorage());

  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    ),
  );

  // Core repositories
  sl.registerLazySingleton<AppSettingsRepository>(
    () =>
        AppSettingsRepositoryImpl(secureStorage: sl(), sharedPreferences: sl()),
  );
}

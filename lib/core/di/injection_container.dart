import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/branch_management/branch_injection.dart';
import '../../features/configuration/configuration_injection.dart';
import '../../features/auth/auth_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Configuration
  await initConfiguration();

  //! Features - Auth
  await initAuth();

  //! Features - Branch Management
  await initBranchManagement();

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => const FlutterSecureStorage());

  sl.registerLazySingleton(() => Dio());
}

import 'package:get_it/get_it.dart';

import 'auth_injection.dart';
import 'configuration_injection.dart';
import 'core_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core (always first)
  await initCore();

  // Features (order matters if dependencies exist)
  await initConfiguration();

  await initAuth();
  // etc.
}

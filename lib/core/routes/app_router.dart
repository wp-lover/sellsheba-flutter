import 'package:dartz/dartz.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';
import '../../features/branch_management/presentation/pages/branch_selection_page.dart';
import '../../features/branch_management/presentation/pages/branch_management_page.dart';
import '../../features/branch_management/presentation/pages/create_branch_page.dart';
import '../../features/branch_management/presentation/pages/main_dashboard_shell.dart';
import '../../features/configuration/presentation/pages/configuration_page.dart';
import '../di/injection_container.dart';
import '../error/failures.dart';
import '../repositories/app_settings_repository.dart';
import 'route_constants.dart';

final repo = sl<AppSettingsRepository>();
final configured = _configured();

Future<Either<Failure, bool>> _configured() async {
  return repo.isConfigured();
}

final router = GoRouter(
  initialLocation: RouteConstants.configurationPath,

  // core/routes/app_router.dart
  redirect: (context, state) async {
    // Temporarily bypass configuration check
    // We'll restore the full logic once ConfigurationRepository is complete

    final isConfigRoute =
        state.uri.toString() == RouteConstants.configurationPath;

    // If user is on config page, let them stay
    if (isConfigRoute) return null;

    // Otherwise, go to login (or later to dashboard if token exists)
    // TODO: Add proper auth check later
    return RouteConstants.loginPath;
  },
  routes: [
    // --- Configuration ---
    GoRoute(
      name: RouteConstants.configuration,
      path: RouteConstants.configurationPath,
      builder: (context, state) => const ConfigurationPage(),
    ),

    // --- Authentication ---
    GoRoute(
      name: RouteConstants.login,
      path: RouteConstants.loginPath,
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      name: RouteConstants.profile,
      path: RouteConstants.profilePath,
      builder: (context, state) => const ProfilePage(),
    ),

    // --- Branch Management ---
    GoRoute(
      name: RouteConstants.branchSelection,
      path: RouteConstants.branchSelectionPath,
      builder: (context, state) => const BranchSelectionPage(),
    ),

    GoRoute(
      name: RouteConstants.branchManagement,
      path: RouteConstants.branchManagementPath,
      builder: (context, state) => const BranchManagementPage(),
    ),

    GoRoute(
      name: RouteConstants.createBranch,
      path: RouteConstants.createBranchPath,
      builder: (context, state) => const CreateBranchPage(),
    ),

    // --- Dashboard ---
    GoRoute(
      name: RouteConstants.dashboard,
      path: RouteConstants.dashboardPath,
      builder: (context, state) => const MainDashboardShell(),
    ),
  ],
);

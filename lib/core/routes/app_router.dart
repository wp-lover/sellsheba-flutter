import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';
import '../../features/branch_management/presentation/pages/branch_selection_page.dart';
import '../../features/branch_management/presentation/pages/branch_management_page.dart';
import '../../features/branch_management/presentation/pages/create_branch_page.dart';
import '../../features/branch_management/presentation/pages/main_dashboard_shell.dart';
import '../../features/configuration/domain/repositories/configuration_repository.dart';
import '../../features/configuration/presentation/pages/configuration_page.dart';
import '../di/injection_container.dart';
import 'route_constants.dart';

final router = GoRouter(
  initialLocation: RouteConstants.configurationPath,
  redirect: (context, state) async {
    // 1. Check Configuration
    final configRepo = sl<ConfigurationRepository>();
    final configResult = await configRepo.getConfiguration();

    final isConfigured = configResult.fold(
      (failure) => false,
      (config) => config != null,
    );

    final isConfigRoute =
        state.uri.toString() == RouteConstants.configurationPath;

    if (!isConfigured) {
      return isConfigRoute ? null : RouteConstants.configurationPath;
    }

    if (isConfigured && isConfigRoute) {
      // If already configured and trying to go to config, send to login
      // TODO: Add check for Auth Token to decide between Login vs Dashboard
      return RouteConstants.loginPath;
    }

    // Default: No redirect (let GoRouter go to the destination)
    return null;
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

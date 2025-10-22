import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/auth_shell.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: SplashScreen.routePath,
    routes: [
      GoRoute(
        path: SplashScreen.routePath,
        builder: SplashScreen.builder,
      ),
      GoRoute(
        path: DashboardScreen.routePath,
        builder: DashboardScreen.builder,
      ),
      ShellRoute(
        builder: AuthShell.build,
        routes: authShellRoutes,
      ),
    ],
  );
});

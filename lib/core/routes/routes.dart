import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:resto_lite/core/routes/router_refresh_stream.dart';
import 'package:resto_lite/features/auth/presentation/screens/login_screen.dart';
import 'package:resto_lite/features/auth/providers/providers.dart';
import 'package:resto_lite/features/home/presentation/screens/home_screen.dart';
import 'package:resto_lite/features/menu/presentation/screens/menu_screen.dart';
import 'package:resto_lite/features/orders/presentation/screens/orders_screen.dart';
import 'package:resto_lite/features/settings/presentation/screens/settings_screen.dart';
import 'package:resto_lite/features/shell/presentation/screens/shell_screen.dart';
import 'package:resto_lite/features/splash/presentation/screens/splash_screen.dart';

enum AppRoute {
  root("/"),
  splash("/splash"),

  /// Auth Pages
  login("/auth/login"),

  /// Main App Pages
  home("/home"),
  orders("/orders"),
  menu("/menu"),
  settings("/settings");

  const AppRoute(this.path);
  final String path;
}

String? handleAuthGuard(String location, bool isAuthenticated) {
  final bool isAuthRoute =
      location == AppRoute.login.path || location == AppRoute.splash.path;

  // If not authenticated, redirect to login unless already on an auth route
  if (!isAuthenticated) {
    return isAuthRoute ? null : AppRoute.login.path;
  }

  // If authenticated and on an auth route, redirect to home
  if (isAuthRoute) {
    return AppRoute.root.path;
  }

  // Otherwise, allow access to the requested route
  return null;
}

final routerProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoute.splash.path,
    refreshListenable: GoRouterRefreshStream([
      authRepository.authStateStream,
    ]),
    redirect: (context, state) async {
      final location = state.matchedLocation;
      // Get the current auth state directly
      final isAuthenticated = authRepository.isAuthenticated;

      // If we're already at the correct location, don't redirect
      if ((location == AppRoute.login.path && !isAuthenticated) ||
          (location == AppRoute.home.path && isAuthenticated)) {
        return null;
      }

      final redirectTo = handleAuthGuard(location, isAuthenticated);
      return redirectTo;
    },
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.root.path,
        redirect: (_, __) {
          return AppRoute.home.path;
        },
      ),
      GoRoute(
        path: AppRoute.login.path,
        builder: (_, __) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ShellScreen(child: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.home.path,
                builder: (_, __) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.orders.path,
                builder: (_, __) => const OrdersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.menu.path,
                builder: (_, __) => const MenuScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.settings.path,
                builder: (_, __) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

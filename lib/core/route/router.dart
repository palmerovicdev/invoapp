import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invoapp/core/auth_status.dart';
import 'package:invoapp/core/route/router_observer.dart';
import 'package:invoapp/core/route/routes.dart';
import 'package:invoapp/presentation/page/home_page.dart';
import 'package:invoapp/presentation/page/login_page.dart';
import 'package:invoapp/presentation/page/splash_page.dart';

final rootNavigationKey = GlobalKey<NavigatorState>();

final authStateNotifier = ValueNotifier<AuthStatus>(AuthStatus.initial);

GoRouter createRouter() {
  return GoRouter(
    initialLocation: Routes.splash.path,
    navigatorKey: rootNavigationKey,
    refreshListenable: authStateNotifier,
    observers: [
      GoRouterObserver(),
    ],
    redirect: (context, state) {
      final authStatus = authStateNotifier.value;
      final isSplash = state.matchedLocation == Routes.splash.path;
      final isLogin = state.matchedLocation == Routes.login.path;
      final isAuthenticated = authStatus == AuthStatus.authenticated;
      final isUnauthenticated = authStatus == AuthStatus.unauthenticated;
      final isChecking =
          authStatus == AuthStatus.checking || authStatus == AuthStatus.initial;

      if (authStatus == AuthStatus.initial && !isSplash) {
        return Routes.splash.path;
      }

      if (isSplash && !isChecking || isUnauthenticated) {
        return isAuthenticated ? Routes.home.path : Routes.login.path;
      }

      if (!isAuthenticated && !isLogin && !isSplash && !isChecking) {
        return '${Routes.login.path}?redirect=true';
      }

      if (isAuthenticated && isLogin) {
        return Routes.home.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash.path,
        name: Routes.splash.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SplashPage(isAuthentication: true),
        ),
      ),
      GoRoute(
        path: Routes.login.path,
        name: Routes.login.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: Routes.home.path,
        name: Routes.home.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: HomePage(),
        ),
      ),
    ],
  );
}

final router = createRouter();

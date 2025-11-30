import 'package:go_router/go_router.dart';

import '../pages/home/home_page.dart';
import '../pages/splash/splash_page.dart';

part 'route_paths.dart';

class AppRouter {
  AppRouter._();

  static GoRouter get appRouter => GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.splash.path,
    routes: <RouteBase>[
      GoRoute(
        name: AppRoutes.splash.name,
        path: AppRoutes.splash.path,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: AppRoutes.home.name,
        path: AppRoutes.home.path,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}

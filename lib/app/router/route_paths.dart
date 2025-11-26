part of 'app_router.dart';

enum AppRoutes {
  splash("/splash"),
  home("/"),
  poll("/polls");

  final String path;

  const AppRoutes(this.path);
}

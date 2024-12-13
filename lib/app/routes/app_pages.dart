import 'package:get/get.dart';
import 'package:live_admin/app/modules/login_module/login_page.dart';
import 'package:live_admin/app/modules/splash_module/splash_page.dart';

part './app_routes.dart';

class AppPages {
  AppPages._();
  static final pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const LoginPage(),
    ),
  ];
}

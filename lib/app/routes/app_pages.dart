import 'package:get/get.dart';
import 'package:live_admin/app/controllers/auth_middleware.dart';
import 'package:live_admin/app/modules/auth_module/pages/forgot_password_page.dart';
import 'package:live_admin/app/modules/auth_module/pages/login_page.dart';
import 'package:live_admin/app/modules/auth_module/pages/reset_password_page.dart';
import 'package:live_admin/app/modules/home/dashboard/views/dashboard_page.dart';
import 'package:live_admin/app/modules/splash_module/splash_page.dart';

part './app_routes.dart';

class AppPages {
  AppPages._();
  static final pages = [
    GetPage(
        name: AppRoutes.initial,
        page: () => const SplashPage(),
        middlewares: [AuthMiddleware()],
        children: []),
    GetPage(
      name: AppRoutes.forgot,
      page: () => ForgotPasswordPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
    ),
    GetPage(
      name: AppRoutes.reset,
      page: () => const ResetPasswordPage(),
    ),
  ];
}

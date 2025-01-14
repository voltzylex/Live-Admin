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
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.forgot,
      page: () => ForgotPasswordPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.reset,
      page: () => const ResetPasswordPage(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}

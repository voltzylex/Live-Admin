import 'package:live_admin/app/controllers/storage_controller.dart';
import 'package:live_admin/app/global_imports.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Temporarily redirect to a loading page (if you have one) or null to let the check happen
    return null;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    // Perform async check before resolving navigation
    _checkLoginStatus();
    return super.onPageCalled(page);
  }

  Future<void> _checkLoginStatus() async {
    final isUserLoggedIn = await SC.to.loadLoginStatus();
    
    // Perform navigation after async check
    await Future.delayed(Duration(seconds: 2), () {
      if (isUserLoggedIn) {
        Get.offAllNamed(AppRoutes.dashboard); // Navigate to Dashboard
      } else {
        Get.offAllNamed(AppRoutes.login); // Navigate to Login
      }
    });
  }
}

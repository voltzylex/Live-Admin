import 'dart:developer';

import 'package:live_admin/app/global_imports.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    SC.to.loadLoginStatus();
    log("Redirect route $route");
    if (route == AppRoutes.initial) {
      // Special case for splash screen
      if (SC.to.isUserLoggedIn.value) {
        return const RouteSettings(
            name: AppRoutes.dashboard); // Redirect to dashboard
      } else {
        return const RouteSettings(name: AppRoutes.login); // Redirect to login
      }
    }

    // For other routes
    if (!SC.to.isUserLoggedIn.value) {
      return const RouteSettings(name: AppRoutes.login); // Redirect to login
    }

    return null; // Allow access
  }
}

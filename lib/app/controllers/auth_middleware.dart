import 'dart:developer';

import 'package:live_admin/app/global_imports.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    log("Route is $route");
    if (SC.to.isUserLoggedIn.value && (route != "/login")) {
      return RouteSettings(
        name: route,
      );
    } else {
      return RouteSettings(
        name: AppRoutes.login,
      );
    }
  }

  // @override
  // GetPage? onPageCalled(GetPage? page) {
  //   log("Void on page called");
  //   if (SC.to.isUserLoggedIn.value) {
  //     return page;
  //   } else {
  //     return GetPage(name: AppRoutes.login, page: () => LoginPage());
  //   }
  // }
}

import 'package:get/get.dart';
import 'package:live_admin/app/routes/app_routes.dart';
import 'package:live_admin/app/ui/pages/home/home_page.dart';
import '../bindings/home_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  
  ];

  // static final unknownRoute = GetPage(
  //   name: AppRoutes.notFound,
  //   page: () => NotFoundPage(),
  // );
}

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/dashboard/views/dashboard_content.dart';
import 'package:live_admin/app/modules/home/membership/views/membership_page.dart';
import 'package:live_admin/app/modules/home/movies/views/movies_page.dart';
import 'package:live_admin/app/modules/home/settings/setting_page.dart';
import 'package:live_admin/app/modules/home/user/user_page.dart';

class DashboardController extends GetxController {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String? currentRoute;

  final RxString currentPage = '/dashboard'.obs;

  void navigateTo(String page) {
    if (currentPage.value != page) {
      currentPage.value = page;
      navigatorKey.currentState?.pushReplacementNamed(page);
    }
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardContent());
      case '/user':
        return MaterialPageRoute(builder: (_) => const UserPage());
      case '/movies':
        return MaterialPageRoute(builder: (_) => const MoviesPage());
      case '/membership':
        return MaterialPageRoute(builder: (_) => const MembershipPage());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(builder: (_) => const DashboardContent());
    }
  }
}

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/dashboard/pages/dashboard_page.dart';

class DashboardController extends GetxController {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String? currentRoute;

  void navigateTo(String route) {
    if (currentRoute == route) return; // Prevent re-navigation to the same page
    currentRoute = route;
    navigatorKey.currentState?.pushNamed(route);
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardContent());
      case '/user':
        return MaterialPageRoute(builder: (_) => const UserContent());
      case '/movies':
        return MaterialPageRoute(builder: (_) => const MoviesContent());
      case '/membership':
        return MaterialPageRoute(builder: (_) => const MembershipContent());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsContent());
      default:
        return MaterialPageRoute(builder: (_) => const DashboardContent());
    }
  }
}

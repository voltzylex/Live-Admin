import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/dashboard/views/dashboard_content.dart';
import 'package:live_admin/app/modules/home/membership/membership_page.dart';
import 'package:live_admin/app/modules/home/movies/views/movies_page.dart';
import 'package:live_admin/app/modules/home/settings/setting_page.dart';
import 'package:live_admin/app/modules/home/user/user_page.dart';

class DashboardContentArea extends StatelessWidget {
  const DashboardContentArea({super.key});

  @override
  Widget build(BuildContext context) {
    final dash = Get.put(DashboardController());
    return Expanded(
      child: Container(
        color: AppColors.black,
        padding: const EdgeInsets.all(30),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.content,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Navigator(
            key: Get.find<DashboardController>().navigatorKey,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/dashboard':
                  return MaterialPageRoute(
                      builder: (_) => const DashboardContent());
                case '/user':
                  return MaterialPageRoute(builder: (_) => const UserPage());
                case '/movies':
                  return MaterialPageRoute(builder: (_) => const MoviesPage());
                case '/membership':
                  return MaterialPageRoute(
                      builder: (_) => const MembershipPage());
                case '/settings':
                  return MaterialPageRoute(
                      builder: (_) => const SettingsPage());
                default:
                  return MaterialPageRoute(
                      builder: (_) => const DashboardContent());
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/dashboard/views/dashboard_content.dart';
import 'package:live_admin/app/modules/home/membership/views/membership_page.dart';
import 'package:live_admin/app/modules/home/movies/views/movies_page.dart';
import 'package:live_admin/app/modules/home/series/views/series_page.dart';
import 'package:live_admin/app/modules/home/settings/setting_page.dart';
import 'package:live_admin/app/modules/home/user/views/user_history_page.dart';
import 'package:live_admin/app/modules/home/user/views/user_page.dart';

class DashboardContentArea extends StatelessWidget {
  DashboardContentArea({super.key});
  final dashboard = Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.black,
        padding: const EdgeInsets.all(30),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.content,
            borderRadius: BorderRadius.circular(kContentRadius),
          ),
          child: Obx(() {
            // Use AnimatedSwitcher for smooth transitions
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300), // Animation duration
              switchInCurve: Curves.easeInOut, // Customize animation curves
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                // Customize the transition (e.g., fade + scale)
                return FadeTransition(
                  opacity: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: _getPage(dashboard.currentPage.value),
            );
          }),
        ),
      ),
    );
  }

  // Method to get the appropriate widget based on the current page
  Widget _getPage(String page) {
    switch (page) {
      case '/dashboard':
        return DashboardContent(
          key: ValueKey('/dashboard'),
          das: dashboard,
        );
      case '/user':
        return const UserPage(key: ValueKey('/user'));
      case '/movies':
        return const MoviesPage(key: ValueKey('/movies'));
      case '/membership':
        return const MembershipPage(key: ValueKey('/membership'));
      case '/settings':
        return const SettingsPage(key: ValueKey('/settings'));
      case "/series":
        return const SeriesPage(key: ValueKey("/series"));
      case "/history":
        return const UserHistoryPage();
      default:
        return DashboardContent(
          key: ValueKey('default'),
          das: dashboard,
        );
    }
  }
}

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/dashboard/widgets/dashboard_appbar.dart';
import 'package:live_admin/app/modules/home/dashboard/widgets/dashboard_content_area.dart';
import 'package:live_admin/app/modules/home/dashboard/widgets/dashboard_nav_items.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final dashboard = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        children: [
          // Dashboard App Bar
          const DashboardAppBar(),

          // Main Body
          Expanded(
            child: Row(
              children: [
                // Left Navigation Bar
                _buildNavigationBar(),

                // Main Content Area
                const DashboardContentArea(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      width: 250,
      color: AppColors.backgroundDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Logo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  Assets.logo,
                  height: 50,
                ),
                const SizedBox(width: 10),
                Text(
                  AppStrings.appName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white),

          // Navigation Items
          Obx(() {
            final currentPage = dashboard.currentPage.value;
            return Column(
              children: [
                DashboardNavItem(
                  label: 'Dashboard',
                  icon: 'assets/images/dashboard.svg',
                  page: '/dashboard',
                  isSelected: currentPage == '/dashboard',
                ),
                DashboardNavItem(
                  label: 'User',
                  icon: 'assets/images/user.svg',
                  page: '/user',
                  isSelected: currentPage == '/user',
                ),
                DashboardNavItem(
                  label: 'Movies',
                  icon: 'assets/images/movies.svg',
                  page: '/movies',
                  isSelected: currentPage == '/movies',
                ),
                DashboardNavItem(
                  label: 'Membership',
                  icon: 'assets/images/membership.svg',
                  page: '/membership',
                  isSelected: currentPage == '/membership',
                ),
                DashboardNavItem(
                  label: 'Settings',
                  icon: 'assets/images/settings.svg',
                  page: '/settings',
                  isSelected: currentPage == '/settings',
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

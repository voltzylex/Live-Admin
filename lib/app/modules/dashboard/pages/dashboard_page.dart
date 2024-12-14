import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/dashboard/controller/dashboard_controller.dart';

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            color: AppColors.backgroundDark,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Search Field
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for anything...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      filled: true,
                      fillColor: AppColors.content,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Notification Icon
                Stack(
                  children: [
                    Icon(Icons.notifications, color: Colors.white, size: 30),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),

                // Profile
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(Assets.logo),
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'John Doe',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Body
          Expanded(
            child: Row(
              children: [
                // Left Navigation Bar
                Container(
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
                              style: TextStyle(
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
                      _NavItem(
                          label: 'Dashboard',
                          icon: Icons.dashboard,
                          page: '/dashboard'),
                      _NavItem(
                          label: 'User', icon: Icons.person, page: '/user'),
                      _NavItem(
                          label: 'Movies', icon: Icons.movie, page: '/movies'),
                      _NavItem(
                          label: 'Membership',
                          icon: Icons.card_membership,
                          page: '/membership'),
                      _NavItem(
                          label: 'Settings',
                          icon: Icons.settings,
                          page: '/settings'),
                    ],
                  ),
                ),

                // Main Content Area
                Expanded(
                  child: Container(
                    color: AppColors.black,
                    padding: EdgeInsets.all(30),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: AppColors.content,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Navigator(
                        key: Get.find<DashboardController>().navigatorKey,
                        onGenerateRoute:
                            Get.find<DashboardController>().onGenerateRoute,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final String page;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.page,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Material(
        color: AppColors.backgroundDark,
        child: InkWell(
          hoverColor: AppColors.primaryLight,
          onTap: () => Get.find<DashboardController>().navigateTo(page),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Dummy Content Widgets
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Dashboard Content'));
  }
}

class UserContent extends StatelessWidget {
  const UserContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('User Content'));
  }
}

class MoviesContent extends StatelessWidget {
  const MoviesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Movies Content'));
  }
}

class MembershipContent extends StatelessWidget {
  const MembershipContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Membership Content'));
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Settings Content'));
  }
}

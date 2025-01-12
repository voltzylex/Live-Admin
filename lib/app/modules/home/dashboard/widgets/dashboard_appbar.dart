import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/themes/app_text_theme.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = SC.to.getUser();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      color: AppColors.backgroundDark,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),

          // Search Field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for anything...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400])
                    .paddingOnly(left: 10),
                filled: true,
                fillColor: AppColors.content,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadius),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Notification Icon
          CircleAvatar(
            backgroundColor: AppColors.content,
            radius: 25,
            child: Stack(
              children: [
                const Icon(Icons.notifications_outlined,
                    color: Colors.white, size: 30),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // Profile Section with Dropdown Menu
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Settings') {
                // Navigate to settings page
                Get.to(() => const SettingsPage());
              } else if (value == 'Logout') {
                // Clear user data and navigate to login screen
                SC.to.clearUserData();
              }
            },
            color: AppColors.black,
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            icon: Container(
              decoration: BoxDecoration(
                color: AppColors.content,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(Assets.logo), // Profile Picture
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    user?.admin?.name ?? "John doe",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.keyboard_arrow_down_rounded)
                ],
              ),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: 'Settings',
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: AppColors.white,
                    ),
                    title: Text('Edit Profile', style: AppTextStyles.title.s18),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Logout',
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text(
                      'Logout',
                      style: AppTextStyles.title.s18,
                    ),
                    onTap: () async {
                      await SC.to
                          .clearUserData()
                          .then((value) => Get.offAllNamed(AppRoutes.login));
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings Page Content'),
      ),
    );
  }
}

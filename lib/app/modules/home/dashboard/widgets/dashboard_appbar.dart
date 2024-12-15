import 'package:live_admin/app/global_imports.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      color: AppColors.backgroundDark,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
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

          // Profile Section
          InkWell(
            onTap: () => SC.to.clearUserData(),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.content,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(Assets.logo), // Profile Picture
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'John Doe',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.keyboard_arrow_down_rounded)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_admin/app/global_imports.dart';

class DashboardNavItem extends StatelessWidget {
  final String label;
  final String icon;
  final String page;
  final bool isSelected;

  const DashboardNavItem({
    required this.label,
    required this.icon,
    required this.page,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Material(
        color: isSelected
            ? AppColors.primary
            : AppColors.backgroundDark, // Change background when selected
        child: InkWell(
          hoverColor: AppColors.primaryLight, // Hover color for the background
          onTap: () => Get.find<DashboardController>().navigateTo(page),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  color: isSelected ? Colors.white : Colors.grey,
                  height: 20,
                ),
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

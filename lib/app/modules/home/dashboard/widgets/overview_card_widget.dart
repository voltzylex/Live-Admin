// Reusable Overview Card Widget (Already Modularized)
import 'package:live_admin/app/global_imports.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    this.iconColor = AppColors.transparent,
    required this.subText,
    required this.subIcon,
    required this.subIconColor,
  });

  final String title;
  final String count;
  final SvgPicture icon;
  final Color iconColor;
  final String subText;
  final IconData subIcon;
  final Color subIconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 117,
      width: 264,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.contentBox,
        borderRadius: BorderRadius.circular(kContentRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: iconColor,
                  child: icon,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.subtitle),
                    Text(count, style: AppTextStyles.title),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Icon(subIcon, size: 20, color: subIconColor),
                const SizedBox(width: 5),
                Text(subText, style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

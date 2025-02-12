import 'dart:developer';

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/dashboard/models/dashboard_model.dart';
import 'package:live_admin/app/modules/home/dashboard/models/dashboard_overview_model.dart';
import 'package:live_admin/app/modules/home/dashboard/widgets/overview_card_widget.dart';
import 'package:shimmer/shimmer.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key, required this.das});
  final DashboardController das;

  @override
  Widget build(BuildContext context) {
    return das.obx(
      (state) => _buildOverviewContent(state, context),
      onLoading: _buildShimmerEffect(), // Shimmer effect while loading
      onError: (error) => Center(child: Text('Error: $error')),
    );
  }

  // Overview Content
  Widget _buildOverviewContent(DashboardModel? state, BuildContext? context) {
    return Container(
      width: Get.width,
      constraints: BoxConstraints(minHeight: 180, maxHeight: 220),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.content,
        borderRadius: BorderRadius.circular(kContentRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Row(
            children: [
              Text("Overview", style: AppTextStyles.title),
              Spacer(),
              PopupMenuButton<String>(
                onSelected: (value) {},
                color: AppColors.content,
                surfaceTintColor: AppColors.green,
                offset: const Offset(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                icon: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text(
                        "Last 30 Days", // Profile
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(width: 10),
                      Opacity(
                        opacity: .6,
                        child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.black,
                        ),
                      )
                    ],
                  ),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<String>(
                      value: '7 Days',
                      child: ListTile(
                        title: Text('7 Days', style: AppTextStyles.title.s18),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: '30 Days',
                      child: ListTile(
                        title: Text(
                          '30 Days',
                          style: AppTextStyles.title.s18,
                        ),
                        onTap: () async {
                          das.fetchDashboard(date: DateTime(
                            DateTime.now().year,
                            
                          ));
                        },
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                // First Overview Card
                Expanded(
                  child: InkWell(
                    onTap: () {
                      log("On tap: Overview Card 1");
                    },
                    child: OverviewCard(
                      title: overviewData.elementAt(0).title,
                      count: state?.overview?.totalUsers.toString() ?? "0",
                      icon: overviewData.elementAt(0).image,
                      iconColor: Color(0xFF21C4FF),
                      subText:
                          "${state?.overview?.usersThisMonth ?? 0} users added this week",
                      subIcon: Icons.add,
                      subIconColor: AppColors.green,
                    ),
                  ),
                ),

                // Second Overview Card
                Expanded(
                  child: InkWell(
                    onTap: () {
                      log("On tap: Overview Card 2");
                    },
                    child: OverviewCard(
                      title: "Movies",
                      count: state?.overview?.totalMovies.toString() ?? "0",
                      icon: overviewData.elementAt(1).image,
                      iconColor: Color(0xFF2CD8BA),
                      subText:
                          "${state?.overview?.moviesThisMonth ?? 0} movies added this month",
                      subIcon: Icons.add,
                      subIconColor: AppColors.green,
                    ),
                  ),
                ),

                // Third Overview Card
                Expanded(
                  child: InkWell(
                    onTap: () {
                      log("On tap: Overview Card 3");
                    },
                    child: OverviewCard(
                      title: overviewData.elementAt(2).title,
                      count: state?.overview?.activsUsers.toString() ?? "0",
                      icon: overviewData.elementAt(2).image,
                      iconColor: overviewData.elementAt(2).color,
                      subText:
                          "${state?.overview?.activeUsersThisMonth ?? 0} increase from last month",
                      subIcon: Icons.north_east,
                      subIconColor: AppColors.green,
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

  // Shimmer Effect
  Widget _buildShimmerEffect() {
    return Container(
      width: Get.width,
      constraints: BoxConstraints(
          minHeight: Get.height * 0.25, maxHeight: Get.height * 0.30),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.content,
        borderRadius: BorderRadius.circular(kContentRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.baseColor,
            highlightColor: AppColors.highlightColor,
            child: Container(
              width: 150,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kContentRadius),
                color: Colors.grey[300],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                _buildShimmerCard(),
                _buildShimmerCard(),
                _buildShimmerCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Shimmer Card Placeholder
  Widget _buildShimmerCard() {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: AppColors.baseColor,
        highlightColor: AppColors.highlightColor,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(kContentRadius),
          ),
        ),
      ),
    );
  }
}

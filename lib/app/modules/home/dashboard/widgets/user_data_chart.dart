import 'package:fl_chart/fl_chart.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/dashboard/models/dashboard_model.dart';
import 'package:shimmer/shimmer.dart';

class UserDataChart extends StatelessWidget {
  const UserDataChart({super.key, required this.das});

  final DashboardController das; // Model containing user data

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.content,
        borderRadius: BorderRadius.circular(kContentRadius),
      ),
      child: das.obx(
        (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("User Data", style: AppTextStyles.title),
              const SizedBox(height: 20),
              Flexible(
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        // Handle touch events for interacting with the pie chart sections
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: showingSections(state),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  indicator("Active users", AppColors.yellow),
                  indicator("Inactive users", AppColors.primary),
                ],
              )
            ],
          );
        },
        onLoading: _buildShimmer(),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.baseColor,
      highlightColor: AppColors.highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 20,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _shimmerIndicator(),
              _shimmerIndicator(),
            ],
          )
        ],
      ),
    );
  }

  Widget _shimmerIndicator() {
    return Row(
      spacing: 10,
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
        Container(
          width: 80,
          height: 20,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget indicator(String title, Color color) {
    return Row(
      spacing: 10,
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
        Text(title),
      ],
    );
  }

  List<PieChartSectionData> showingSections(DashboardModel? state) {
    final double activeUsersPercentage = 20.0;
    final double inactiveUsersPercentage =
        state!.userData?.inactiveUsersPercentage.toDouble() ?? 0.0;

    return [
      PieChartSectionData(
        color: AppColors.yellow, // Active users color
        value: activeUsersPercentage,
        title: '${activeUsersPercentage.toInt()}%',
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: AppColors.primary, // Inactive users color
        value: inactiveUsersPercentage,
        title: '${inactiveUsersPercentage.toInt()}%',
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        badgePositionPercentageOffset: .98,
      ),
    ];
  }
}

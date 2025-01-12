import 'package:fl_chart/fl_chart.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:shimmer/shimmer.dart';

class RevenueReportWidget extends StatelessWidget {
  const RevenueReportWidget({super.key, required this.das});
  final DashboardController das; // Model containing labels and data

  @override
  Widget build(BuildContext context) {
    final List<num> randomRevenueData = [12, 25, 18, 30, 22, 15, 10];
    return Container(
      height: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.content,
        borderRadius: BorderRadius.circular(kContentRadius),
      ),
      child: das.obx(
        (state) {
          if (state == null) {
            // Show shimmer when data is loading
            return _buildShimmer();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Revenue Report", style: AppTextStyles.title),
              const SizedBox(height: 20),
              Expanded(
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(axisNameWidget: SizedBox()),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 10,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          interval: 1,
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() >= 0 &&
                                value.toInt() <
                                    state.revenueReport!.labels.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  state.revenueReport!.labels[value.toInt()]
                                      .substring(0, 3),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: (randomRevenueData.length - 1).toDouble(),
                    minY: 0,
                    maxY: randomRevenueData
                            .reduce((a, b) => a > b ? a : b)
                            .toDouble() +
                        10, // Adding some padding above the max value
                    lineBarsData: [
                      LineChartBarData(
                        spots: randomRevenueData
                            .asMap()
                            .entries
                            .map(
                              (entry) => FlSpot(
                                entry.key.toDouble(),
                                entry.value.toDouble(),
                              ),
                            )
                            .toList(),
                        isCurved: true,
                        color: AppColors.chart,
                        barWidth: 3,
                        belowBarData: BarAreaData(
                          show: true,
                          color: AppColors.chart.withOpacity(.05),
                        ),
                        dotData: FlDotData(show: true), // Dots on points
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        onLoading: _buildShimmer(), // Shimmer during loading
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
          ),
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
}

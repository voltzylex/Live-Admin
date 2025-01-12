// Revenue and User Data Section
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/dashboard/widgets/revenue_report.dart';
import 'package:live_admin/app/modules/home/dashboard/widgets/user_data_chart.dart';

class RevenueAndUserDataSection extends StatelessWidget {
  const RevenueAndUserDataSection({super.key, required this.das});
  final DashboardController das;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: RevenueReportWidget(
            das: das,
          ), // Revenue Report Widget
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: UserDataChart(
            das: das,
          ), // User Data Chart Widget
        ),
      ],
    );
  }
}

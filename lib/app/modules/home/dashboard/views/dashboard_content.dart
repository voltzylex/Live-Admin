import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/dashboard/widgets/new_member_section.dart';
import 'package:live_admin/app/modules/home/dashboard/widgets/overview_section.dart';
import 'package:live_admin/app/modules/home/dashboard/widgets/revenue_user_data.dart';

// Main Dashboard Content Widget
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key, required this.das});
  final DashboardController das;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            OverviewSection(das: das), // Overview Section
            const SizedBox(height: 20),
            RevenueAndUserDataSection(
                das: das), // Revenue and User Data Section
            const SizedBox(height: 20),
            NewMembersSection(
              das: das,
            ) // New Members Section
          ],
        ),
      ),
    );
  }
}

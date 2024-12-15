// Dummy Content Widgets
import 'package:live_admin/app/global_imports.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(SC.to.username.isNotEmpty
            ? SC.to.username.value
            : 'Dashboard Content'));
  }
}

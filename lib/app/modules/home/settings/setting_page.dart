import 'package:live_admin/app/global_imports.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          SC.to.clearUserData();
          Get.offAllNamed(AppRoutes.initial);
        },
        child: Text(
          'Settings Page',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

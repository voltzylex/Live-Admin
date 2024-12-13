import 'package:live_admin/app/global_imports.dart';

import 'widgets/left_panel.dart';
import 'widgets/right_panel.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Row(
          children: const [
            LeftPanel(), // Left panel widget
            RightPanel(), // Right panel widget
          ],
        ),
      ),
    );
  }
}

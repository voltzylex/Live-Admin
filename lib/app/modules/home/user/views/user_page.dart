import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/user/controllers/user_controller.dart';
import 'package:live_admin/app/modules/home/user/views/widgets/add_user_body.dart';
import 'package:live_admin/app/modules/home/user/views/widgets/list_user_body.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserController.to;
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Obx(
        () => user.isUser.value
            ? ListUserBody(
                user: user,
              )
            : AddUserBody(
                user: user,
              ),
      ),
    );
  }
}

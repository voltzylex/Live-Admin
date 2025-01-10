import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/membership/controllers/membership_controller.dart';
import 'package:live_admin/app/modules/home/membership/widgets/add_membership.dart';
import 'package:live_admin/app/modules/home/membership/widgets/list_membership_body.dart';

class MembershipPage extends StatelessWidget {
  const MembershipPage({super.key});

  @override
  Widget build(BuildContext context) {
    final membership = MembershipController().to;
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Obx(
        () => !membership.isMembership.value
            ? ListMembershipBody(
                membership: membership,
              )
            : AddMembershipBody(
                membership: membership,
              ),
      ),
    );
  }
}

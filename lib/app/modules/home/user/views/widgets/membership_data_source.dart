import 'dart:developer';

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/membership/controllers/membership_controller.dart';
import 'package:live_admin/app/modules/home/membership/models/membership_model.dart';
import 'package:live_admin/app/modules/home/user/views/user_history_page.dart';
import 'package:live_admin/app/utils/constants.dart';

class MembershipDataSource extends DataTableSource {
  final BuildContext context;
  final List<MyPlan> plans;
  final void Function(int id) onEdit;
  final void Function(int id) onDelete;
  final MembershipController cont;
  MembershipDataSource(
    this.context,
    this.plans,
    this.cont, {
    required this.onEdit,
    required this.onDelete,
  });

  @override
  DataRow getRow(int index) {
    final plan = plans[index];
    return DataRow2(
      specificRowHeight: null,
      onTap: () {
        // Get.to(() => UserHistoryPage());
        cont.user = plan.user;
        log("Member is ${cont.user?.toJson()}");
        Get.find<DashboardController>().changePage(UserHistoryPage.name);
      },
      color: WidgetStateProperty.all(
          index % 2 == 0 ? AppColors.table1 : AppColors.table2),
      cells: [
        // ID
        DataCell(Text("#${plan.id}")),

        // Name
        DataCell(Text(plan.user!.name)),

        // Email
        DataCell(SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(plan.user!.email),
        )),

        // Role
        DataCell(Text(plan.name)),
        DataCell(Text(formatDateTime(plan.startDate ?? DateTime.now()))),
        DataCell(Text(formatDateTime(plan.endDate ?? DateTime.now()))),
        // Status
        DataCell(Text(
          "Inactive",
          style: TextStyle(
              // color: user.status ? AppColors.green : AppColors.red,
              ),
        )),

        // Actions
        DataCell(FittedBox(
          child: Row(
            children: [
              // Status Toggle

              // Edit Button
              IconButton(
                icon: SvgPicture.asset(Assets.edit),
                onPressed: () => onEdit(plan.id),
              ),

              // Delete Button
              IconButton(
                icon: SvgPicture.asset(Assets.delete),
                onPressed: () => onDelete(plan.id),
              ),
            ],
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => plans.length;

  @override
  int get selectedRowCount => 0;
}

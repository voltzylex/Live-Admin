import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/user/models/users_model.dart';
import 'package:live_admin/app/utils/constants.dart';

class UserDataSource extends DataTableSource {
  final BuildContext context;
  final List<User> users;
  final void Function(User id) onEdit;
  final void Function(User id) onDelete;

  UserDataSource(
    this.context,
    this.users, {
    required this.onEdit,
    required this.onDelete,
  });

  @override
  DataRow getRow(int index) {
    final user = users[index];
    return DataRow2(
      specificRowHeight: null,
      color: WidgetStateProperty.all(
          index % 2 == 0 ? AppColors.table1 : AppColors.table2),
      cells: [
        // ID
        DataCell(Text("#${user.id}")),

        // Name
        DataCell(Text(user.name)),

        // Email
        DataCell(SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(user.email),
        )),

        // Status
        // DataCell(Text(
        //   "Inactive",
        //   style: TextStyle(
        //       // color: user.status ? AppColors.green : AppColors.red,
        //       ),
        // )),
        DataCell(Text(
          formatDateTime(user.createdAt),
          style: TextStyle(),
        )),
        DataCell(Text(
          formatDateTime(user.updatedAt),
          style: TextStyle(),
        )),

        // Actions
        DataCell(FittedBox(
          child: Row(
            children: [
              // Status Toggle

              // Edit Button
              IconButton(
                icon: SvgPicture.asset(Assets.edit),
                onPressed: () => onEdit(user),
              ),

              // Delete Button
              IconButton(
                icon: SvgPicture.asset(Assets.delete),
                onPressed: () => onDelete(user),
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
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/user/controllers/user_controller.dart';
import 'package:live_admin/app/modules/home/user/models/users_model.dart';
import 'package:live_admin/app/modules/home/user/views/widgets/add_user_body.dart';
import 'package:live_admin/app/modules/home/user/views/widgets/user_data_source.dart';

class ListUserBody extends StatefulWidget {
  final UserController user;
  const ListUserBody({super.key, required this.user});

  @override
  State<ListUserBody> createState() => _ListUserBodyState();
}

class _ListUserBodyState extends State<ListUserBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Row with Title and Add Button
        _buildHeader(),

        // User List Table with Pagination
        Expanded(
          child: widget.user.obx(
            (state) => _buildUserTable(state!, context),
            onLoading: ShimmerTable(),
            onError: (error) => Center(
              child: Text(
                error.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),

        // Pagination Controls
        widget.user.obx(
          (state) => _buildPagination(state!),
          onLoading: const SizedBox(height: 60),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Users",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        BaseButton(
          onPressed: widget.user.toggleUser,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(kRadius),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: const [
                Icon(Icons.add, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  "Add Users",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ],
    ).paddingAll(20);
  }

  Widget _buildUserTable(UsersModel state, BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: PaginatedDataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 800,
        availableRowsPerPage: const [5, 10, 15],
        showCheckboxColumn: true,
        headingRowColor: MaterialStateProperty.all(AppColors.content),
        columns: const [
          DataColumn2(label: Text('ID'), size: ColumnSize.S),
          DataColumn2(label: Text('Name'), size: ColumnSize.L),
          DataColumn2(label: Text('Email'), size: ColumnSize.M),
          DataColumn2(label: Text('Create Date'), size: ColumnSize.M),
          DataColumn2(label: Text('End Date'), size: ColumnSize.M),
          // DataColumn2(label: Text('Status'), size: ColumnSize.S),
          DataColumn2(label: Text('Actions'), size: ColumnSize.S),
        ],
        hidePaginator: true,
        source: UserDataSource(
          context,
          state.users,
          onEdit: _editUser,
          onDelete: _deleteUser,
        ),
      ),
    );
  }

  Widget _buildPagination(UsersModel state) {
    final currentPage = state.meta!.currentPage;
    final lastPage = state.meta!.lastPage;

    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14).whiteColor,
              children: [
                const TextSpan(text: 'Showing '),
                TextSpan(
                  text: '$currentPage',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const TextSpan(text: ' to '),
                TextSpan(
                  text: '${state.users.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const TextSpan(text: ' of '),
                TextSpan(
                  text: 'total',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const TextSpan(text: ' results'),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (currentPage > 1) {
                    widget.user.currentPage.value--;
                  }
                },
                icon: const Icon(Icons.navigate_before),
              ),
              ...List.generate(lastPage.toInt(), (index) {
                final page = index + 1;
                final isActive = page == currentPage;
                return GestureDetector(
                  onTap: () => widget.user.currentPage.value = page,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.white : AppColors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      page.toString(),
                      style: AppTextStyles.base.copyWith(
                        color: isActive ? AppColors.primary : AppColors.white,
                      ),
                    ),
                  ),
                );
              }),
              IconButton(
                onPressed: () {
                  if (currentPage < lastPage) {
                    widget.user.currentPage.value++;
                  }
                },
                icon: const Icon(Icons.navigate_next),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editUser(User u) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.content, // Set a solid background color
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: AddUserBody(
            user: widget.user,
            isEdit: true,
            cUser: u,
          ),
        ),
      ),
    );
  }

  void _deleteUser(User u) async {
    await widget.user.deleteUser(u.id, context);
  }
}

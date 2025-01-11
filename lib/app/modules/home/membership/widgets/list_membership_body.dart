// ListMembershipBody.dart
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/membership/controllers/membership_controller.dart';
import 'package:live_admin/app/modules/home/membership/models/membership_model.dart';
import 'package:live_admin/app/modules/home/user/widgets/membership_data_source.dart';
import 'package:live_admin/app/themes/app_text_theme.dart';

class ListMembershipBody extends StatelessWidget {
  final MembershipController membership;
  const ListMembershipBody({super.key, required this.membership});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Row with Title and Add Button
        _buildHeader(),

        // Membership List Table with Pagination
        Expanded(
          child: membership.obx(
            (state) => _buildMembershipTable(state!, context),
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
        membership.obx(
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
          "Membership Plans",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        BaseButton(
          onPressed: () {},
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
                  "Add Membership",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ],
    ).paddingAll(20);
  }

  Widget _buildMembershipTable(MembershipModel state, BuildContext context) {
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
          DataColumn2(label: Text('Role'), size: ColumnSize.M),
          DataColumn2(label: Text('Status'), size: ColumnSize.S),
          DataColumn2(label: Text('Actions'), size: ColumnSize.S),
        ],
        hidePaginator: true,
        source: MembershipDataSource(
          context,
          state.myPlans,
          onEdit: (id) => _editUser(context, id),
          onDelete: (id) => _deleteUser(context, id),
        ),
      ),
    );
  }

  Widget _buildPagination(MembershipModel state) {
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
                  text: '${state.myPlans.length}',
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
                    membership.currenP.value--;
                  }
                },
                icon: const Icon(Icons.navigate_before),
              ),
              ...List.generate(lastPage.toInt(), (index) {
                final page = index + 1;
                final isActive = page == currentPage;
                return GestureDetector(
                  onTap: () => membership.currenP.value = page,
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
                    membership.currenP.value++;
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

  void _editUser(BuildContext context, int id) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit user with ID: $id')),
    );
  }

  void _deleteUser(BuildContext context, int id) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted user with ID: $id')),
    );
  }
}

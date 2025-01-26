import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/dashboard/models/dashboard_model.dart';
import 'package:live_admin/app/utils/constants.dart';

class NewMembersSection extends StatelessWidget {
  const NewMembersSection({super.key, required this.das});
  final DashboardController das;

  @override
  Widget build(BuildContext context) {
    return das.obx(
      (state) {
        if (state != null && state.newMembers.isNotEmpty) {
          return Container(
            width: Get.width,
            // padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.content,
              borderRadius: BorderRadius.circular(kContentRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("New Members", style: AppTextStyles.title)
                    .paddingSymmetric(horizontal: 20)
                    .paddingOnly(top: 10),
                const Divider(color: AppColors.white),
                // Member Rows
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.newMembers.length,
                  itemBuilder: (context, index) {
                    final member = state.newMembers[index];
                    return _buildMemberRow(member, index);
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("No new members available."),
          );
        }
      },
      onLoading: SizedBox(height: 400, child: ShimmerTable()),
      onError: (error) => Center(
        child:
            Text(error.toString(), style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  // Helper method to build each row for a member
  Widget _buildMemberRow(NewMember member, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show header only for the first row (index == 0)
        if (index == 0)
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Adjusted spacing
            children: [
              _buildMemberColumn("ID", flex: 2, index),
              _buildMemberColumn('User Name', flex: 2, index),
              _buildMemberColumn('Email', flex: 2, index),
              _buildMemberColumn('Create Date', flex: 4, index),
              _buildMemberColumn('Status', flex: 2, index),
            ],
          ).paddingSymmetric(horizontal: 20),
        ColoredBox(
          color: index % 2 == 0 ? AppColors.table1 : AppColors.table2,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Adjusted spacing
            children: [
              _buildMemberColumn(member.id.toString(), flex: 2, index),
              _buildMemberColumn(member.name, flex: 4, index),
              _buildMemberColumn((member.email ), flex: 4, index),
              _buildMemberColumn(
                  formatDateTime(member.createdAt), flex: 4, index),
              _buildMemberColumn(
                  (member.emailVerifiedAt != null
                      ? 'Verified'
                      : 'Not Verified'),
                  flex: 2,
                  index),
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ],
    );
  }

  // Helper method to build a single column in a row
  Widget _buildMemberColumn(String value, int index, {required int flex}) {
    // return Flexible(
    //   flex: flex,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 8.0),
    //     child: Column(
    //       crossAxisAlignment:
    //           CrossAxisAlignment.center, // Align the text in columns
    //       children: [
    //         Text(
    //           value,
    //           style: index == 0
    //               ? AppTextStyles.subtitle.copyWith(
    //                   fontWeight: FontWeight.bold,
    //                   color: AppColors.hintText,
    //                 )
    //               : AppTextStyles.subtitle,
    //           // textAlign: TextAlign
    //           //     .center, // Ensure center alignment for both header and data cells
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          value,
          style: index == 0
              ? AppTextStyles.subtitle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.hintText,
                )
              : AppTextStyles.subtitle,
          // textAlign: TextAlign
          //     .center, // Ensure center alignment for both header and data cells
        ),
      ),
    );
  }
}

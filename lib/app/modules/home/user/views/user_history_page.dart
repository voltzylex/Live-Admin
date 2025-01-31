// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/membership/controllers/membership_controller.dart';
import 'package:live_admin/app/modules/home/membership/models/history_model.dart';
import 'package:live_admin/app/modules/home/membership/models/membership_model.dart';
import 'package:live_admin/app/utils/constants.dart';
import 'package:live_admin/app/utils/loading.dart';

class UserHistoryPage extends StatefulWidget {
  const UserHistoryPage({super.key});
  static const name = "/history";
  @override
  State<UserHistoryPage> createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {
  MembershipHistoryModel? mem;
  @override
  void initState() {
    log("User History Page Initiated");
    super.initState();
    if (mounted) fetchHistory();
  }

  final cont = MembershipController().to;
  fetchHistory() async {
    log("User History ${cont.user?.toJson()}");
    mem = await cont.getMembershipHistory(cont.user?.id ?? 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Details Text
          Text(
            "User Details",
            style: AppTextStyles.title,
          ).paddingAll(20),
          const SizedBox(height: 12),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: ColoredBox(
              color: AppColors.white.withOpacity(.08),
              child: Text(
                "Profile Details",
                style: TextStyle().whiteColor,
              ).paddingOnly(left: 20, top: 5, bottom: 5),
            ),
          ),
          // Row with Profile Image and User Info
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            leading: SizedBox(
              width: 80, // Set width for the image container
              height: 80, // Set height for the image container
              child: CircleAvatar(
                radius: 40, // Control the image size
                backgroundColor: AppColors.borderL1,
                backgroundImage: NetworkImage(cont.user?.photo ?? ""),
              ),
            ),
            title: Text(
              cont.user?.name ?? "",
              style: AppTextStyles.title,
            ),
            subtitle: Row(
              children: [
                Icon(Icons.phone, color: AppColors.borderL1),
                const SizedBox(width: 5), // Add spacing between icon and text
                Text(
                  cont.user?.phone ?? "0000000",
                  style: AppTextStyles.caption.whiteColor,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Member History Table Title
          const Text(
            "Member History",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ).paddingOnly(left: 20, top: 5, bottom: 5),
          const SizedBox(height: 12),

          // Table UI
          Expanded(
            child: Obx(
              () {
                if (cont.isHistoryL.value) {
                  return Center(
                    child: Loading(
                      opacity: 0,
                      loadingColor: AppColors.white.withOpacity(.8),
                      loadingType: LoadingType.dualRing,
                    ),
                  );
                }
                if (mem == null) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          "User History Not Found ",
                          style: AppTextStyles.title,
                        ),
                        IconButton(
                            onPressed: () => fetchHistory(),
                            icon: Icon(Icons.restart_alt_rounded))
                      ],
                    ),
                  );
                }
                return Theme(
                  data: ThemeData.dark().copyWith(
                    scaffoldBackgroundColor: AppColors.red,
                  ),
                  child: PaginatedDataTable2(
                    columnSpacing: 40,
                    horizontalMargin: 20,
                    columns: const [
                      DataColumn(
                          label: Text("ID",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("User",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text("Create Date",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )),
                      DataColumn(
                          label: Text("End Date",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Amount",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Status",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    source: _UserHistoryDataSource(
                        plan: mem!.plans), // Custom data source
                    // rowsPerPage: 5, // Adjust based on need
                    hidePaginator: true,

                    headingRowColor: MaterialStateProperty.all(
                        Colors.transparent), // Transparent header background
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _UserHistoryDataSource extends DataTableSource {
  List<MyPlan> plan;
  _UserHistoryDataSource({
    required this.plan,
  });
  bool checkActiveStatus(DateTime startTime, DateTime endTime) {
    DateTime now = DateTime.now();

    // Check if the current time is between the start and end time
    if (now.isAfter(startTime) && now.isBefore(endTime)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  DataRow getRow(int index) {
    final p = plan[index];
    return DataRow2(
        color: WidgetStateProperty.all(
            index % 2 == 0 ? AppColors.table1 : AppColors.table2),
        cells: [
          DataCell(Text(p.userId.toString())),
          DataCell(Text(p.name)),
          DataCell(Text(formatDateTime(p.startDate ?? DateTime.now()))),
          DataCell(Text(formatDateTime(p.endDate ?? DateTime.now()))),
          DataCell(Text(p.price)),
          DataCell(
            Text(
              checkActiveStatus(p.startDate!, p.endDate!)
                  ? "Active"
                  : "Inactive",
              style: AppTextStyles.base.copyWith(
                  color: checkActiveStatus(p.startDate!, p.endDate!)
                      ? AppColors.green
                      : AppColors.red),
            ),
          ),
        ]);
  }

  @override
  int get rowCount => plan.length;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => 0;
}

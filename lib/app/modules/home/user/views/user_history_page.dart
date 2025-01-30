import 'dart:developer';

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/membership/controllers/membership_controller.dart';

class UserHistoryPage extends StatefulWidget {
  const UserHistoryPage({super.key});
  static const name = "/history";
  @override
  State<UserHistoryPage> createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {
  @override
  void initState() {
    log("User History Page Initiated");
    super.initState();
  }

  final membership = MembershipController().to;
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
                backgroundImage: NetworkImage(membership.user?.photo ?? ""),
              ),
            ),
            title: Text(
              membership.user?.name ?? "",
              style: AppTextStyles.title,
            ),
            subtitle: Row(
              children: [
                Icon(Icons.phone, color: AppColors.borderL1),
                const SizedBox(width: 5), // Add spacing between icon and text
                Text(
                  membership.user?.phone ?? "0000000",
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
          ),
          const SizedBox(height: 12),

          // Table UI
          Expanded(
            child: SingleChildScrollView(
              child: Theme(
                data: ThemeData.dark(),
                child: PaginatedDataTable(
                  columnSpacing: 40,
                  horizontalMargin: 20,
                  columns: const [
                    DataColumn(
                        label: Text("Date",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text("Activity",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text("Status",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  source: _UserHistoryDataSource(), // Custom data source
                  rowsPerPage: 5, // Adjust based on need
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserHistoryDataSource extends DataTableSource {
  final List<Map<String, String>> _data = [
    {"date": "2024-01-28", "activity": "Joined Membership", "status": "Active"},
    {
      "date": "2024-02-10",
      "activity": "Updated Profile",
      "status": "Completed"
    },
    {
      "date": "2024-02-15",
      "activity": "Renewed Subscription",
      "status": "Pending"
    },
  ];

  @override
  DataRow getRow(int index) {
    return DataRow2(cells: [
      DataCell(Text(_data[index]["date"]!)),
      DataCell(Text(_data[index]["activity"]!)),
      DataCell(Text(_data[index]["status"]!)),
    ]);
  }

  @override
  int get rowCount => _data.length;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => 0;
}

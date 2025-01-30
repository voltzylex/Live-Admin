import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/membership/controllers/membership_controller.dart';

class UserHistoryPage extends StatefulWidget {
  const UserHistoryPage({super.key});

  @override
  State<UserHistoryPage> createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {
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
                backgroundImage: NetworkImage(""),
              ),
            ),
            title: Text(
              "User",
              style: AppTextStyles.title,
            ),
            subtitle: Row(
              children: [
                Icon(Icons.phone, color: AppColors.borderL1),
                const SizedBox(width: 5), // Add spacing between icon and text
                Text(
                  membership.user?.phone ?? "",
                  style: AppTextStyles.caption,
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
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
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
                rows: [
                  DataRow(cells: [
                    DataCell(Text("2024-01-28")),
                    DataCell(Text("Joined Membership")),
                    DataCell(Text("Active")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("2024-02-10")),
                    DataCell(Text("Updated Profile")),
                    DataCell(Text("Completed")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("2024-02-15")),
                    DataCell(Text("Renewed Subscription")),
                    DataCell(Text("Pending")),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

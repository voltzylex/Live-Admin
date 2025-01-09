// import 'package:live_admin/app/global_imports.dart';
// import 'package:live_admin/app/modules/home/membership/controllers/membership_controller.dart';
// import 'package:live_admin/app/modules/home/membership/models/membership_model.dart';
// import 'package:live_admin/app/modules/home/membership/widgets/membership_data_source.dart';
// import 'package:live_admin/app/modules/home/membership/views/shimmer_table.dart';
// import 'package:live_admin/app/themes/app_text_theme.dart';

// class MembershipListPage extends StatefulWidget {
//   const MembershipListPage({super.key, required this.membershipController});
//   final MembershipController membershipController;

//   @override
//   State<MembershipListPage> createState() => _MembershipListPageState();
// }

// class _MembershipListPageState extends State<MembershipListPage> {
//   // Handle toggle status
//   void _toggleStatus(int id) {
//     // Implement status toggle logic here
//   }

//   // Handle edit membership action
//   void _editMembership(int id) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Edit membership with ID: $id')),
//     );
//   }

//   // Handle delete membership action
//   void _deleteMembership(int id) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Deleted membership with ID: $id')),
//     );
//   }

//   // Navigate to the next page
//   void _nextPage(int lastPage) {
//     if (widget.membershipController.currentPage.value < lastPage) {
//       widget.membershipController.currentPage.value++;
//     }
//   }

//   // Navigate to the previous page
//   void _prevPage() {
//     if (widget.membershipController.currentPage.value > 1) {
//       widget.membershipController.currentPage.value--;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.transparent,
//       body: Column(
//         children: [
//           // Header Row with Title and Add Membership Button
//           _buildHeader(),

//           // Membership List Table with Pagination
//           Expanded(
//             child: widget.membershipController.obx(
//               (state) => _buildMembershipTable(state!),
//               onLoading: const ShimmerTable(),
//               onError: (error) => Center(
//                 child: Text(
//                   error.toString(),
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),

//           // Pagination Controls
//           widget.membershipController.obx(
//             (state) => _buildPagination(state!),
//             onLoading: const SizedBox(height: 60),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: const Text(
//             'Memberships',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         BaseButton(
//           onPressed: () {
//             widget.membershipController.isAdding.toggle();
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: Get.width * 0.04,
//               vertical: 10,
//             ),
//             margin: const EdgeInsets.only(right: 10),
//             decoration: BoxDecoration(
//               color: AppColors.primary,
//               borderRadius: BorderRadius.circular(kRadius),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.add, color: AppColors.white),
//                 const SizedBox(width: 10),
//                 const Text(
//                   "Add Membership",
//                   style: TextStyle(color: AppColors.white),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMembershipTable(MembershipModel state) {
//     return Theme(
//       data: ThemeData.dark(),
//       child: PaginatedDataTable2(
//         columnSpacing: 12,
//         horizontalMargin: 12,
//         minWidth: 800,
//         availableRowsPerPage: const [5, 10, 15],
//         showCheckboxColumn: true,
//         headingRowColor: MaterialStateProperty.all(AppColors.content),
//         columns: const [
//           DataColumn2(label: Text('ID'), size: ColumnSize.S),
//           DataColumn2(label: Text('Membership Name'), size: ColumnSize.L),
//           DataColumn2(label: Text('Price'), size: ColumnSize.M),
//           DataColumn2(label: Text('Duration'), size: ColumnSize.M),
//           DataColumn2(label: Text('Status'), size: ColumnSize.S),
//           DataColumn2(label: Text('Actions'), size: ColumnSize.S),
//         ],
//         hidePaginator: true,
//         source: MembershipDataSource(
//           context,
//           state.memberships,
//           onEdit: _editMembership,
//           onDelete: _deleteMembership,
//           onToggleStatus: _toggleStatus,
//         ),
//       ),
//     );
//   }

//   Widget _buildPagination(MembershipModel state) {
//     final currentPage = state.meta!.currentPage;
//     final lastPage = state.meta!.lastPage;

//     return Container(
//       height: 60,
//       width: Get.width,
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(color: AppColors.transparent),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           RichText(
//             text: TextSpan(
//               style: const TextStyle(fontSize: 14),
//               children: [
//                 const TextSpan(text: 'Showing '),
//                 TextSpan(
//                   text: '${currentPage.toInt()}',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 const TextSpan(text: ' to '),
//                 TextSpan(
//                   text: '${state.memberships.length}',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 const TextSpan(text: ' of '),
//                 TextSpan(
//                   text: '${state.meta!.total}',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 const TextSpan(text: ' results'),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () => _prevPage(),
//                 icon: const Icon(Icons.navigate_before),
//               ),
//               ...List.generate(lastPage.toInt(), (index) {
//                 final page = index + 1;
//                 final isActive = page == currentPage;
//                 return GestureDetector(
//                   onTap: () => setState(() {
//                     // widget.membershipController.currentPage.value = page;
//                   }),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 7),
//                     margin: const EdgeInsets.symmetric(horizontal: 2),
//                     decoration: BoxDecoration(
//                       color: isActive ? AppColors.white : AppColors.transparent,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Text(
//                       page.toString(),
//                       style: AppTextStyles.base.copyWith(
//                         color: isActive ? AppColors.primary : AppColors.white,
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//               IconButton(
//                 onPressed: () => _nextPage(lastPage.toInt()),
//                 icon: const Icon(Icons.navigate_next),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
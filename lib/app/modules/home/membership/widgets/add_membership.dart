import 'dart:developer';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/membership/controllers/membership_controller.dart';
import 'package:live_admin/app/modules/home/membership/models/plans_model.dart';
import 'package:live_admin/app/modules/home/user/models/users_model.dart';
import 'package:live_admin/app/utils/loading.dart';

class AddMembershipBody extends StatefulWidget {
  final MembershipController membership;
  const AddMembershipBody({super.key, required this.membership});

  @override
  State<AddMembershipBody> createState() => _AddMembershipBodyState();
}

class _AddMembershipBodyState extends State<AddMembershipBody> {
  final _key = GlobalKey<FormState>();

  Plan? _selectedPlan;
  User? _selectedUser; // Selected user for membership
  final TextEditingController _userController =
      TextEditingController(); // Controller for typeahead
  final TextEditingController _startField = TextEditingController();
  final TextEditingController _endField = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchPlan();
  }

  fetchPlan() async {
    widget.membership.plans.value = await widget.membership.fetchPlans();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 2.5,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Add New Membership Plan",
              style: AppTextStyles.title,
            ).paddingAll(20),

            // TypeAheadField for searching and selecting a user
            _selectedUser == null
                ? _buildUserTypeAhead()
                : _buildSelectedUserTile(),

            const SizedBox(height: 20),

            // Dropdown for selecting a plan
            Obx(
              () {
                if (widget.membership.isPlanL.value) {
                  return SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Loading(
                        opacity: 0,
                        loadingColor: AppColors.white,
                        loadingType: LoadingType.dualRing,
                      ));
                }
                if (widget.membership.plans.value != null) {
                  return _buildPlanDropdown();
                }
                return SizedBox();
              },
            ),

            const SizedBox(height: 20),

            // Save and Cancel buttons
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Expanded(child: _buildCancelButton()),
                Expanded(child: _buildSaveButton()),
              ],
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    );
  }

  /// Builds the TypeAheadField for searching users
  Widget _buildUserTypeAhead() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TypeAheadField<User>(
        suggestionsCallback: (pattern) {
          // Filter users based on the input pattern
          return widget.membership.users.state!.users
              .where((user) =>
                  user.name.toLowerCase().contains(pattern.toLowerCase()))
              .toList();
        },
        controller: _userController,
        builder: (context, controller, focusNode) {
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              labelText: "Search User",
              hintText: "Enter user name or email",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (_selectedUser == null) {
                return "Please select a user";
              }
              return null;
            },
          );
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(
              suggestion.name,
            ),
          );
        },
        onSelected: (suggestion) {
          setState(() {
            _selectedUser = suggestion;
            _userController.clear();
          });
        },
      ),
    );
  }

  /// Displays the selected user tile
  Widget _buildSelectedUserTile() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: SizedBox(
        width: 80, // Set width for the image container
        height: 80, // Set height for the image container
        child: CircleAvatar(
          radius: 40, // Control the image size
          backgroundColor: AppColors.borderL1,
          backgroundImage:
              _selectedUser?.photo != null && _selectedUser!.photo!.isNotEmpty
                  ? NetworkImage(_selectedUser!.photo!)
                  : null,
          child: _selectedUser?.photo == null || _selectedUser!.photo!.isEmpty
              ? const Icon(Icons.person,
                  color: Colors.white, size: 40) // Fallback icon
              : null,
        ),
      ),
      title: Text(
        _selectedUser?.name ?? "",
        style: AppTextStyles.title,
      ),
      subtitle: Row(
        children: [
          Icon(Icons.phone, color: AppColors.borderL1),
          const SizedBox(width: 5), // Add spacing between icon and text
          Text(
            _selectedUser?.phone ?? "",
            style: AppTextStyles.caption,
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.close, color: Colors.red),
        onPressed: () {
          setState(() {
            _selectedUser = null;
          });
        },
      ),
    );
  }

  final Rxn<DateTime> _startDate = Rxn(); // Selected start date
  final Rxn<DateTime> _endDate = Rxn(); // Calculated end date

  /// Builds the dropdown for selecting plans
  Widget _buildPlanDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButtonFormField<Plan>(
            decoration: InputDecoration(
              labelText: "Select Plan",
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderL1),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderL1),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderL1),
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: AppColors.white.withOpacity(0.08),
            ),
            dropdownColor: AppColors.content,
            value: _selectedPlan,
            style: const TextStyle(color: Colors.white),
            items: widget.membership.plans.value!.plans.map((e) {
              return DropdownMenuItem<Plan>(
                value: e,
                child:
                    Text(e.name, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedPlan = value;

                // Reset dates when a new plan is selected
                _startDate.value = null;
                _endDate.value = null;
              });
            },
            validator: (value) {
              if (value == null) {
                return "Please select a plan";
              }
              return null;
            },
          ),
        ),
        if (_selectedPlan != null) ...[
          const SizedBox(height: 20),

          // Box for Plan Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.borderL1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Plan Name: ${_selectedPlan?.name ?? 'N/A'}",
                      style: AppTextStyles.caption),
                  const SizedBox(height: 10),
                  Text("Duration: ${_selectedPlan?.duration ?? 'N/A'} days",
                      style: AppTextStyles.caption),
                  const SizedBox(height: 10),
                  Text("Price: \$${_selectedPlan?.price ?? 'N/A'}",
                      style: AppTextStyles.caption),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          _buildDateFields(), // Show date fields when a plan is selected
        ],
      ],
    );
  }

  /// Builds the Start Date and End Date fields
  /// Builds the Start Date and End Date fields
  Widget _buildDateFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Start Date Field
          Expanded(
            child: GestureDetector(
              onTap: _selectStartDate,
              child: Obx(
                () => AbsorbPointer(
                  child: TextFormField(
                    controller: _startField,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Start Date",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.borderL1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.borderL1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: AppColors.white.withOpacity(0.08),
                      hintText: _startDate.value != null
                          ? "${_startDate.value!.day}/${_startDate.value!.month}/${_startDate.value!.year}"
                          : "Select Start Date",
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),

          // End Date Field
          Expanded(
            child: Obx(
              () => TextFormField(
                controller: _endField,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "End Date",
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderL1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderL1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: AppColors.white.withOpacity(0.08),
                  hintText: _endDate.value != null
                      ? "${_endDate.value!.day}/${_endDate.value!.month}/${_endDate.value!.year}"
                      : "End Date",
                  hintStyle: const TextStyle(color: Colors.white),
                  // suffixIcon: CircleAvatar(
                  //   backgroundColor: AppColors.borderL1,
                  //   child: Text(_selectedPlan?.duration.toString() ?? "0"),
                  // ).paddingSymmetric(horizontal: 5, vertical: 5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Opens the date picker for Start Date and calculates the End Date
  Future<void> _selectStartDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: AppColors.content,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _startDate.value = selectedDate;
        log("Starte Date: ${_startDate.value!.day}/${_startDate.value!.month}/${_startDate.value!.year}");
        _startField.text =
            "${_startDate.value!.day}/${_startDate.value!.month}/${_startDate.value!.year}";
        // Calculate end date based on the selected plan's duration
        if (_selectedPlan?.duration != null) {
          _endDate.value = _startDate.value!
              .add(Duration(days: _selectedPlan!.duration.toInt()));
          _endField.text =
              "${_endDate.value!.day}/${_endDate.value!.month}/${_endDate.value!.year}";
        }
        log("End Date: ${_endDate.value!.day}/${_endDate.value!.month}/${_endDate.value!.year}");
      });
    }
  }

  /// Builds the cancel button
  Widget _buildCancelButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedUser = null;
          _selectedPlan = null;
          _userController.clear();
        });
        Get.back();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.content,
        maximumSize: Size(Get.width, 50),
        minimumSize: Size(100, 50),
        side: BorderSide(color: AppColors.borderL1),
      ),
      child: Text("Cancel", style: TextStyle(color: AppColors.borderL1)),
    );
  }

  /// Builds the save button
  /// Builds the save button with validations
  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_selectedUser == null) {
          ToastHelper.showToast(
            context: context,
            title: 'Please Select User',
            description: 'You need to select a user before proceeding!',
            type: ToastType.error,
          );
          return;
        }
        if (_selectedPlan == null) {
          ToastHelper.showToast(
            context: context,
            title: 'Please Select Plan',
            description:
                'You need to select a membership plan before proceeding!',
            type: ToastType.error,
          );
          return;
        }
        if (_startDate.value == null) {
          ToastHelper.showToast(
            context: context,
            title: 'Please Select Start Date',
            description: 'You need to select a start date before proceeding!',
            type: ToastType.error,
          );
          return;
        }

        // Save logic here
        // widget.membership.addMembership(
        //   context,
        //   user: _selectedUser,
        //   plan: _selectedPlan,
        //   startDate: _startDate.value,
        //   endDate: _endDate.value,
        // );
      },
      style: ElevatedButton.styleFrom(
        maximumSize: Size(Get.width, 50),
        minimumSize: Size(100, 50),
        backgroundColor: AppColors.green1,
      ),
      child: const Text("Active", style: TextStyle(color: Colors.white)),
    );
  }
}

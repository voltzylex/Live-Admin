import 'dart:developer';

import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/membership/controllers/membership_controller.dart';
import 'package:live_admin/app/themes/app_text_theme.dart';

class MembershipPage extends StatelessWidget {
  const MembershipPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mem = Get.put(MembershipController());

    // Form key for validation
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // if (!mem.isUpload.value) {
    //   return MembershipListPage(
    //     mem: mem,
    //   );
    // }
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title - Upload Membership
              Text(
                'Add Membership',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).paddingAll(20),
              const SizedBox(height: 16),

              // Membership Details Box
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Membership Name field
                    Text('Membership Name',
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter membership name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a membership name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Membership Price field
                    Text('Membership Price',
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter membership price',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a membership price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Membership Duration field
                    Text('Membership Duration (in months)',
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter duration',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter membership duration';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Membership Description field
                    Text('Membership Description',
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: mem.descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Enter membership description',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Buttons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Cancel Button
                        ElevatedButton(
                          onPressed: () {
                            formKey.currentState?.reset();
                            mem.isUpload.toggle();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.borderL1,
                            backgroundColor: AppColors.content,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(kRadius),
                                side: BorderSide(color: AppColors.borderL1)),
                          ),
                          child: Text('Cancel'),
                        ),
                        SizedBox(width: 16),

                        // Save Button
                        ElevatedButton(
                          onPressed: () async {
                            log("Auth header : ${await ApiConnect.instance.authHeader()}");

                            if (formKey.currentState?.validate() ?? false) {}
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(kRadius),
                            ),
                          ),
                          child: Text(
                            AppStrings.save,
                            style: AppTextStyles.base.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

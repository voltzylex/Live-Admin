// AddMembershipBody.dart
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/membership/controllers/membership_controller.dart';
import 'package:live_admin/app/themes/app_text_theme.dart';

class AddMembershipBody extends StatefulWidget {
  final MembershipController membership;
  const AddMembershipBody({super.key, required this.membership});

  @override
  State<AddMembershipBody> createState() => _AddMembershipBodyState();
}

class _AddMembershipBodyState extends State<AddMembershipBody> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const String planName = "Plan Name",
        price = "Price",
        duration = "Duration",
        features = "Features";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add New Membership Plan",
            style: AppTextStyles.title,
          ).paddingAll(20),
          SizedBox(
            width: Get.width,
            child: ColoredBox(
              color: AppColors.white.withOpacity(.08),
              child: Text(
                "Plan Details",
                style: TextStyle().whiteColor,
              ).paddingOnly(left: 20, top: 5, bottom: 5),
            ),
          ),
          const SizedBox(height: 16),
          Form(
            key: _key,
            child: Column(
              spacing: 10,
              children: [
                tField(
                  controller: widget.membership.planName,
                  title: planName,
                  hint: planName,
                  validator: (value) => _validateField(value, planName),
                ),
                const SizedBox(height: 10),
                tField(
                  controller: widget.membership.price,
                  title: price,
                  hint: price,
                  validator: (value) => _validatePrice(value),
                ),
                const SizedBox(height: 10),
                tField(
                  controller: widget.membership.duration,
                  title: duration,
                  hint: duration,
                  validator: (value) => _validateField(value, duration),
                ),
                const SizedBox(height: 10),
                tField(
                  controller: widget.membership.features,
                  title: features,
                  hint: features,
                  validator: (value) => _validateField(value, features),
                ),
                const SizedBox(height: 20),
              ],
            ).paddingSymmetric(horizontal: 20),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 10,
            children: [
              BaseButton(
                onPressed: (){},
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderL1),
                      borderRadius: BorderRadius.circular(kRadius)),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: AppColors.borderL1),
                  ),
                ),
              ),
              BaseButton(
                onPressed: (){},
                //  widget.membership.addMembership(context, key: _key),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(kRadius)),
                  child: Text(
                    "Save",
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 20)
        ],
      ),
    );
  }

  Widget tField({
    required TextEditingController controller,
    required String title,
    required String hint,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        ),
      ],
    );
  }

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Price is required";
    }
    if (double.tryParse(value) == null) {
      return "Enter a valid price";
    }
    return null;
  }
}
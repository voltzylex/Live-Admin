import 'dart:convert';
import 'dart:developer';

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/user/controllers/user_controller.dart';
import 'package:live_admin/app/modules/home/user/models/add_user_model.dart';
import 'package:live_admin/app/modules/home/user/models/users_model.dart';

class AddUserBody extends StatefulWidget {
  final UserController user;
  final bool isEdit;
  final User? cUser;
  const AddUserBody(
      {super.key, required this.user, this.isEdit = false, this.cUser});

  @override
  State<AddUserBody> createState() => _AddUserBodyState();
}

class _AddUserBodyState extends State<AddUserBody> {
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setEditField();
  }

  setEditField() {
    if (mounted && widget.isEdit) {
      final w = widget;
      w.user.email.text = w.cUser?.email ?? "";
      w.user.firstName.text = w.cUser?.name.split(" ")[0] ?? "";
      w.user.lastName.text = w.cUser?.name.split(" ")[1] ?? "";
      w.user.phone.text = w.cUser?.phone ?? "";
    }
  }

  bool isEmailMatch() {
    final match =
        widget.user.email.text.trim() == (widget.cUser?.email).toString().trim()
            ? true
            : false;
    log("match email is ${widget.user.email.text.trim()} == ${(widget.cUser?.email).toString().trim()} is email matched $match");
    return match;
  }

  bool isMobileMatch() =>
      widget.user.phone.text == (widget.cUser?.phone ?? "") ? true : false;
  @override
  Widget build(BuildContext context) {
    const String first = "First Name",
        last = "Last Name",
        mobile = "Mobile No.",
        userId = "Email",
        create = "Create Password",
        confirm = "Confirm Password";

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isEdit ? "Edit user" : "Add New User",
              style: AppTextStyles.title,
            ).paddingAll(20),
            SizedBox(
              width: Get.width,
              child: ColoredBox(
                color: AppColors.white.withOpacity(.08),
                child: Text(
                  "Profile Details",
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
                  profilePicker(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        child: tField(
                          controller: widget.user.firstName,
                          title: first,
                          hint: first,
                          validator: (value) => validateName(value, first),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: tField(
                          controller: widget.user.lastName,
                          title: last,
                          hint: last,
                          validator: (value) => validateName(value, last),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: tField(
                          controller: widget.user.phone,
                          title: mobile,
                          hint: mobile,
                          validator: validateMobile,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: tField(
                          controller: widget.user.email,
                          title: userId,
                          hint: userId,
                          validator: validateEmailId,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (!widget.isEdit)
                    Row(
                      children: [
                        Flexible(
                          child: Obx(
                            () => tField(
                              controller: widget.user.createP,
                              title: create,
                              hint: create,
                              isObscure: widget.user.createObs.value,
                              validator: validatePassword,
                              prefix: IconButton(
                                  onPressed: widget.user.createObs.toggle,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  icon: Icon(!widget.user.createObs.value
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Obx(() {
                            return tField(
                              controller: widget.user.confirmP,
                              title: confirm,
                              hint: confirm,
                              isObscure: widget.user.confirmObs.value,
                              validator: (value) => validateConfirmPassword(
                                  value, widget.user.createP.text),
                              prefix: IconButton(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  onPressed: widget.user.confirmObs.toggle,
                                  icon: Icon(!widget.user.confirmObs.value
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                            );
                          }),
                        ),
                      ],
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
                  onPressed: () {
                    widget.user.onCancel();
                    if (widget.isEdit) {
                      Get.back();
                    }
                  },
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
                  onPressed: () async {
                    final w = widget.user;
                    final data = AddUser(
                        name: "${w.firstName.text}${w.lastName.text}",
                        email: w.email.text,
                        password: w.createP.text,
                        passwordConfirmation: w.confirmP.text,
                        phone: int.tryParse(w.phone.text),
                        photo: w.image.value != null
                            ? base64Encode(w.image.value!)
                            : "");
                    if (widget.isEdit) {
                      log("New email data ${isEmailMatch() ? null : w.email.text}");
                      final editData = data.copyWith(
                        email: isEmailMatch() ? null : w.email.text,
                        photo: isMobileMatch() ? null : w.phone.text,
                      );
                      log("Edit data ${editData.toJson()}");
                      await widget.user.editUser(context,
                          user: editData, id: widget.cUser!.id);
                    } else {
                      await widget.user.addUser(context, key: _key, user: data);
                    }
                  },
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
      ),
    );
  }

  ImageProvider? checkImageType() {
    if (widget.isEdit && (widget.cUser?.photo?.isNotEmpty ?? false)) {
      return NetworkImage(widget.cUser!.photo!);
    } else {
      return widget.user.image.value != null
          ? MemoryImage(widget.user.image.value!)
          : null;
    }
  }

  bool isImagePresented() {
    if (widget.isEdit && (widget.cUser?.photo?.isNotEmpty ?? false)) {
      return true;
    } else {
      return false;
    }
  }

  Row profilePicker() {
    return Row(
      children: [
        Obx(
          () {
            widget.user.image.value;
            return CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primary,
              backgroundImage: checkImageType(),
              child: Obx(
                () {
                  widget.user.image.value;
                  if (isImagePresented()) {
                    return SizedBox();
                  }
                  if (widget.user.image.value != null) {
                    return SizedBox();
                  }

                  return Icon(Icons.person);
                },
              ),
            );
          },
        ),
        const SizedBox(width: 20),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseButton(
                onPressed: () => widget.user.pickImage(context),
                child: Container(
                  padding: const EdgeInsets.all(10).copyWith(
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(kRadius),
                  ),
                  child: Text(
                    "Upload Photo",
                    style: AppTextStyles.base.whiteColor,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Allowed JPG, GIF or PNG. Max size of 800K",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget tField({
    required TextEditingController controller,
    required String title,
    required String hint,
    String? Function(String?)? validator,
    bool isObscure = false,
    Widget? prefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: prefix,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        ),
      ],
    );
  }

  // Validation functions
  String? validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    if (value.trim().length < 2) {
      return "$fieldName must be at least 2 characters long";
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Mobile Number is required";
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Enter a valid 10-digit Mobile Number";
    }
    return null;
  }

  String? validateEmailId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "User email is required";
    }
    if (value.isEmail == false) {
      return "User ID must be at least 5 characters long";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.trim().isEmpty) {
      return "Confirm Password is required";
    }
    if (value != originalPassword) {
      return "Passwords do not match";
    }
    return null;
  }
}

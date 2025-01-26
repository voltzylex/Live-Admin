import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/user/models/add_user_model.dart';
import 'package:live_admin/app/modules/home/user/models/users_model.dart';
import 'package:live_admin/app/utils/constants.dart';

class UserController extends GetxController with StateMixin<UsersModel> {
 static UserController get to => Get.isRegistered<UserController>()
      ? Get.find<UserController>()
      : Get.put(UserController());
  RxBool isUser = true.obs;
  final Rxn<Uint8List> image = Rxn();
  final picker = ImagePicker();
  final RxBool createObs = true.obs, confirmObs = true.obs;
  TextEditingController firstName = TextEditingController(),
      lastName = TextEditingController(),
      phone = TextEditingController(),
      email = TextEditingController(),
      createP = TextEditingController(),
      confirmP = TextEditingController();

  RxInt currentPage = 1.obs;
  @override
  onInit() {
    super.onInit();
    getUsers();
  }

  Rx<bool> toggleUser() => isUser.toggle();
  // Add movies-specific logic here.
  Future<void> pickImage(BuildContext context) async {
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image.value = Uint8List.fromList(await img.readAsBytes());
    } else {
      ToastHelper.showToast(
        context: context,
        title: 'Please Select Image',
        description: 'please select image before proceding!',
        type: ToastType.error,
      );
    }
  }

  Future<void> addUser(BuildContext context,
      {required GlobalKey<FormState> key, required AddUser user}) async {
    if (key.currentState?.validate() ?? false) {
      try {
        // Call the API to add the user
        showLoading();
        final res = await ApiConnect.instance.addUsers(user);

        // Check if the response indicates success and display the appropriate toast
        if (res.body["success"] == true) {
          await ToastHelper.showToast(
            context: context,
            title: 'Success',
            description: res.body["message"] ?? 'User added successfully!',
            type: ToastType.success,
          );
          getUsers();
          await onCancel();
        } else {
          ToastHelper.showToast(
            context: context,
            title: 'Error',
            description: res.body["message"] ?? 'Something went wrong!',
            type: ToastType.error,
          );
        }
        hideLoading();
      } catch (error) {
        hideLoading();
        log("Error on add user $error");
        // Handle any unexpected exceptions
        ToastHelper.showToast(
          context: context,
          title: 'Error',
          description: 'An unexpected error occurred: ${error.toString()}',
          type: ToastType.error,
        );
      }
    } else {
      ToastHelper.showToast(
        context: context,
        title: 'Validation Error',
        description: 'Please fill all required fields before proceeding!',
        type: ToastType.error,
      );
    }
  }

  Future<void> editUser(BuildContext context,
      {required int id, required AddUser user}) async {
    try {
      // Call the API to add the user
      showLoading();
      final res =
          await ApiConnect.instance.updateUsers(id.toString(), user: user);

      // Check if the response indicates success and display the appropriate toast
      if (res.body["success"] == true) {
        await ToastHelper.showToast(
          context: context,
          title: 'Success',
          description: res.body["message"] ?? 'User added successfully!',
          type: ToastType.success,
        );
        getUsers();
        await onCancel();
      } else {
        ToastHelper.showToast(
          context: context,
          title: 'Error',
          description: res.body["message"] ?? 'Something went wrong!',
          type: ToastType.error,
        );
      }
      hideLoading();
    } catch (error) {
      hideLoading();
      log("Error on add user $error");
      // Handle any unexpected exceptions
      ToastHelper.showToast(
        context: context,
        title: 'Error',
        description: 'An unexpected error occurred: ${error.toString()}',
        type: ToastType.error,
      );
    }
  }

  Future<void> onCancel() async {
    firstName.clear();
    lastName.clear();
    phone.clear();
    email.clear();
    createP.clear();
    confirmP.clear();
    image.value = null;
    isUser(true);
  }

  Future<void> getUsers() async {
    try {
      change(null, status: RxStatus.loading()); // Set loading state
      final res = await ApiConnect.instance.getUsers();
      final user = UsersModel.fromJson(res.body);
      // movies.addAll(mov.movies);
      change(user, status: RxStatus.success());
    } catch (e) {
      // Set error state
      change(null, status: RxStatus.error('Failed to load data $e'));
    }
  }

  Future<void> deleteUser(int id, BuildContext context) async {
    try {
      final res = await ApiConnect.instance.deleteUser(id);
      if (res.statusCode == 200) {
        state!.users.removeWhere(
          (element) => element.id == id,
        );
        update();
        ToastHelper.showToast(
          context: context,
          title: 'Deleted Succesfully',
          description: res.body["message"] ?? 'User Deleted Succesfully',
          type: ToastType.error,
        );
      }
    } catch (e) {
      ToastHelper.showToast(
        context: context,
        title: 'Some error occured',
        description: e.toString(),
        type: ToastType.error,
      );
    }
  }
}

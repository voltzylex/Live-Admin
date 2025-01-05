import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:live_admin/app/global_imports.dart';

class UserController extends GetxController {
  UserController get to => Get.isRegistered<UserController>()
      ? Get.find<UserController>()
      : Get.put(UserController());
  RxBool isUser = true.obs;
  final Rxn<Uint8List> image = Rxn();
  final picker = ImagePicker();
  final RxBool createObs = true.obs, confirmObs = true.obs;
  TextEditingController firstName = TextEditingController(),
      lastName = TextEditingController(),
      mobileNumber = TextEditingController(),
      userId = TextEditingController(),
      createP = TextEditingController(),
      confirmP = TextEditingController();

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

  Future<void> addUser(
    BuildContext context, {
    required GlobalKey<FormState> key,
  }) async {
    if (image.value == null || (key.currentState?.validate() ?? false)) {
      ToastHelper.showToast(
        context: context,
        title: 'Please Select Image',
        description: 'please select image before proceding!',
        type: ToastType.error,
      );
      return;
    }
  }

  Future<void> onCancel() async {
    firstName.clear();
    lastName.clear();
    mobileNumber.clear();
    userId.clear();
    createP.clear();
    confirmP.clear();
    image.value = null;
    isUser(true);
  }
}

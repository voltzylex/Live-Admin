import 'dart:async';
import 'dart:developer';

import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/auth_module/controllers/login_model.dart';

class AuthController extends GetxController {
  RxBool isTimerActive = false.obs;
  RxInt secondsRemaining = 60.obs;
  RxBool isObscurePassword = true.obs;
  RxBool isLoading = false.obs;
  RxBool isObscureConfirmPassword = true.obs;
  Rxn<LoginModel> user = Rxn();
  Timer? _timer;

  // Start timer for resend link
  void startTimer() {
    isTimerActive.value = true;
    secondsRemaining.value = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        _timer?.cancel();
        isTimerActive.value = false;
      }
    });
  }

  // Call your logic for forgot password (sending reset link)
  void sendResetLink(String email) {
    // Implement your forgot password logic here
    print("Sending reset link to $email");
    startTimer(); // Start the timer once the link is sent
  }

  void togglePasswordVisibility() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> login(
      String username, String password, BuildContext context) async {
    try {
      // You can now use user.value to get the current LoginModel
      // Call your API or perform further actions
      // Example:
      isLoading(true);
      final response = await ApiConnect.instance.login(
        username,
        password,
      );
      isLoading(false);
      user(response);
      await SC.to.saveUser(response);
      log("User Data: ${user.toJson()}");
      if (user.value != null) {
        Get.offAllNamed(AppRoutes.dashboard);
      }
    } catch (e) {
      isLoading(false);
      ToastHelper.showToast(
        context: context,
        title: e.toString(),
        description: '',
        type: ToastType.error,
      );
      print('Login error: $e');
    }
  }
}

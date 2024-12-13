import 'dart:async';

import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isTimerActive = false.obs;
  RxInt secondsRemaining = 60.obs;
  RxBool isObscurePassword = true.obs;
  RxBool isObscureConfirmPassword = true.obs;

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
}

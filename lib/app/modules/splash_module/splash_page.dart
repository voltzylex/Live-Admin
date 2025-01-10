import 'dart:async';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/utils/widgets/app_bar/custom_app_bar.dart';

class SplashPage extends GetWidget {
  const SplashPage({Key? key}) : super(key: key);
  void _navigateAfterSplash() {
    Timer(const Duration(seconds: 2), () async {
      // Load login status from SharedPreferences
      await SC.to.loadLoginStatus();

      // Navigate based on login status
      if (SC.to.isUserLoggedIn.value) {
        Get.offAllNamed(AppRoutes.dashboard); // Go to dashboard if logged in
      } else {
        Get.offAllNamed(AppRoutes.login); // Go to login if not logged in
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Navigate to Home after 2 seconds

    _navigateAfterSplash();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          // Center content (Logo and Title)
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App Logo
                  Image.asset(
                    Assets.logo,
                    width: Get.size.width * 0.3, // Adjust logo size
                  ),
                  const SizedBox(height: 16),

                  // App Name
                  Text(
                    AppStrings.appName, // Replace with your app's name
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Adjust based on your theme
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Loader at the bottom
          Padding(
            padding: EdgeInsets.only(
              bottom: Get.context!.mediaQueryPadding.bottom + 20,
            ),
            child: SpinKitFadingCircle(
              color: AppColors.white,
              size: 50.0, // Adjust loader size
            ),
          ),
        ],
      ),
    );
  }
}

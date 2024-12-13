import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/auth_module/auth_controller.dart';

import '../widgets/left_panel.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 800;
        return Scaffold(
          body: Row(
            children: [
              if (!isSmallScreen) const LeftPanel(),
              Expanded(
                child: Container(
                  width: Get.width / 2,
                  color: AppColors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo and Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.logo,
                            height: 90,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              AppStrings.appName,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Title
                      Text(
                        "Reset Password",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 16),

                      // Description
                      Text(
                        "Enter your new password below",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 32),

                      // New Password
                      Obx(() => TextFormField(
                            obscureText: authController.isObscurePassword.value,
                            decoration: InputDecoration(
                              hintText: "New Password",
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle,
                              filled:
                                  Theme.of(context).inputDecorationTheme.filled,
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              border:
                                  Theme.of(context).inputDecorationTheme.border,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  authController.isObscurePassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  authController.togglePasswordVisibility();
                                },
                              ),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Password is required"),
                              FormBuilderValidators.minLength(6,
                                  errorText: "Minimum 6 characters"),
                            ]),
                          )),
                      const SizedBox(height: 16),

                      // Confirm Password
                      Obx(() => TextFormField(
                            obscureText:
                                authController.isObscureConfirmPassword.value,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle,
                              filled:
                                  Theme.of(context).inputDecorationTheme.filled,
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              border:
                                  Theme.of(context).inputDecorationTheme.border,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  authController.isObscureConfirmPassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  authController
                                      .toggleConfirmPasswordVisibility();
                                },
                              ),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText:
                                      "Password confirmation is required"),
                              FormBuilderValidators.minLength(6,
                                  errorText: "Minimum 6 characters"),
                            ]),
                          )),
                      const SizedBox(height: 32),

                      // Reset Password Button
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add reset password logic
                          },
                          child: const Text("Reset Password"),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // "Go Back to Login?" Section
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Text(
                              "Remember your password?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white70),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.offNamedUntil(
                                    AppRoutes.login,
                                    (route) =>
                                        route.settings.name == AppRoutes.login);
                                // Navigate back to login page
                              },
                              child: Text(
                                "Log in",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

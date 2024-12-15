import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/auth_module/controllers/auth_controller.dart';

import '../widgets/left_panel.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController =
        Get.put(AuthController()); // Get instance of AuthController

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
                        "Forgot Password",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 16),

                      // Description
                      Text(
                        "Enter your email and we'll send you instructions to reset your password.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 32),

                      // Email Form
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
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
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "Email is required"),
                            FormBuilderValidators.email(
                                errorText: "Enter a valid email"),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Resend Link with Timer
                      Align(
                        alignment: Alignment.centerRight,
                        child: Obx(
                          () => authController.isTimerActive.value
                              ? Text(
                                  "Resend link: ${authController.secondsRemaining.value}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                )
                              : TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      // Start the timer via AuthController
                                      authController.startTimer();
                                      // Trigger resend logic
                                      authController
                                          .sendResetLink(_emailController.text);
                                    }
                                  },
                                  child: Text(
                                    "Resend link",
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
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Send Reset Link Button
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: authController.isTimerActive.value
                              ? null // Disable button during timer
                              : () {
                                  Get.toNamed(AppRoutes.reset);
                                  // if (_formKey.currentState?.validate() ??
                                  //     false) {
                                  //   // Email validation passed
                                  //   authController.startTimer();
                                  //   // Call your forgot password logic
                                  //   authController
                                  //       .sendResetLink(_emailController.text);
                                  // }
                                },
                          child: Text(
                            "Send Reset Link",
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // "Remember Your Password?" Section
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
                                Get.back(); // Navigate back to login page
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

import 'package:live_admin/app/global_imports.dart';

class RightPanel extends StatefulWidget {
  const RightPanel({super.key});

  @override
  _RightPanelState createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  final _formKey = GlobalKey<FormState>();
  final _passwordVisibility = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _passwordVisibility.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: Get.width / 2,
        color: AppColors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Icon and Title
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
              const SizedBox(height: 40),

              // Welcome Text
              Row(
                children: [
                  Text(
                    AppStrings.welcome,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.waving_hand,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                AppStrings.loginDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),

              // Email TextFormField
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                  filled: Theme.of(context).inputDecorationTheme.filled,
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  border: Theme.of(context).inputDecorationTheme.border,
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Email is required"),
                  FormBuilderValidators.email(errorText: "Enter a valid email"),
                ]),
              ),
              const SizedBox(height: 16),

              // Password TextFormField with Hide/Unhide
              ValueListenableBuilder(
                valueListenable: _passwordVisibility,
                builder: (context, isPasswordVisible, child) {
                  return TextFormField(
                    obscureText: isPasswordVisible,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle:
                          Theme.of(context).inputDecorationTheme.hintStyle,
                      filled: Theme.of(context).inputDecorationTheme.filled,
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      border: Theme.of(context).inputDecorationTheme.border,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          _passwordVisibility.value = !isPasswordVisible;
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Password is required"),
                      FormBuilderValidators.minLength(6,
                          errorText: "Minimum 6 characters"),
                    ]),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Add Forgot Password logic here
                    Get.toNamed(AppRoutes.forgot);
                  },
                  child: Text(
                    AppStrings.forgot,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Elevated Button
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      print("Validation passed");
                      // Handle successful login
                      Get.toNamed(AppRoutes.dashboard);
                    } else {
                      print("Validation failed");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    AppStrings.login,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

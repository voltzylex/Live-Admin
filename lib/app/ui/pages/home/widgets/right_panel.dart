import 'package:live_admin/app/global_imports.dart';

class RightPanel extends StatelessWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: Get.width / 2,
        color: AppColors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Icon and Title
            Row(
              children: [
                const Icon(
                  Icons.abc,
                  size: 90,
                ),
                const SizedBox(width: 10),
                Text(
                  AppStrings.appName,
                  style:
                      Theme.of(context).textTheme.headlineLarge, // Using theme
                ),
              ],
            ),
            const SizedBox(height: 40), // Spacing between sections

            // Welcome Text
            Row(
              children: [
                Text(
                  AppStrings.welcome,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ), // Using and customizing theme
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.waving_hand,
                  color: Theme.of(context)
                      .colorScheme
                      .secondary, // Secondary color
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              AppStrings.loginDescription,
              style: Theme.of(context).textTheme.bodyMedium, // Using theme
            ),
            const SizedBox(height: 32),

            // Email TextField
            TextField(
              key: UniqueKey(),
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                // filled: Theme.of(context).inputDecorationTheme.filled,
                // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                border: Theme.of(context).inputDecorationTheme.border,
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Password TextField
            TextField(
              key: UniqueKey(),
              obscureText: true, // Obscure password input
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                filled: Theme.of(context).inputDecorationTheme.filled,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                border: Theme.of(context).inputDecorationTheme.border,
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Add Forgot Password logic here
                },
                child: Text(
                  AppStrings.forgot,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ), // Using and customizing theme
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
                  // Add Login Button logic here
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
    );
  }
}

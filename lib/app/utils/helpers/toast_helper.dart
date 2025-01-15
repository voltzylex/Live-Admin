import 'package:live_admin/app/global_imports.dart';
import 'package:toastification/toastification.dart'; // Add this dependency in pubspec.yaml

class ToastHelper {
  static Future<   void> showToast({
    required BuildContext context,
    required String title,
    required String description,
    required ToastType type,
    Duration? duration,
  })async {
    Color primaryColor;
    IconData iconData;

    // Customize the appearance based on the toast type
    switch (type) {
      case ToastType.success:
        primaryColor = AppColors.green;
        iconData = Icons.check_circle;
        break;
      case ToastType.error:
        primaryColor = AppColors.red;
        iconData = Icons.error;
        break;
      case ToastType.info:
        primaryColor = AppColors.blue;
        iconData = Icons.info;
        break;
      case ToastType.warning:
        primaryColor = AppColors.orange;
        iconData = Icons.warning;
        break;
    }

    // Call toastification.show
    toastification.show(
      context: context,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      description: Text(
        description,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white70,
        ),
      ),
      style: ToastificationStyle.fillColored,
      primaryColor: primaryColor,
      icon: Icon(iconData, color: Colors.white),
      autoCloseDuration: duration ?? const Duration(seconds: 3),
    );
  }
}

// Enum to define toast types
enum ToastType { success, error, info, warning }

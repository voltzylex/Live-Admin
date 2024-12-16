import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/utils/constants.dart';
import 'package:toastification/toastification.dart';

class MoviesController extends GetxController {
  final Rxn<Uint8List> image = Rxn();
  final picker = ImagePicker();
  final type = movieTypes;
  final category = movieCategories;
  RxString selectedCategory = ''.obs;
  RxString selectedType = ''.obs;
  // Add movies-specific logic here.
  Future<void> pickImage(BuildContext context) async {
    // For mobile (Android, iOS), use ImagePicker
    // For web, use ImagePickerWeb

    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image.value = Uint8List.fromList(await img.readAsBytes());
    } else {
      toastification.show(
        context: context, // Optional if using ToastificationWrapper
        title: const Text(
          'No image selected',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        description: const Text(
          'Please upload an image before proceeding.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        style: ToastificationStyle.fillColored,
        primaryColor: AppColors.red,
        icon: const Icon(Icons.error, color: Colors.white),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }
}

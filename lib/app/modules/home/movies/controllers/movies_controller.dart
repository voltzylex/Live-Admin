import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_admin/app/global_imports.dart';

class MoviesController extends GetxController {
  final Rxn<Uint8List> image = Rxn();
  final picker = ImagePicker();
  // Add movies-specific logic here.
  Future<void> pickImage() async {
    // For mobile (Android, iOS), use ImagePicker
    // For web, use ImagePickerWeb

    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image.value = Uint8List.fromList(await img.readAsBytes());
    } else {
     
    }
  }
}

// widgets/series_cover_image.dart
import 'package:flutter/material.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';

class SeriesCoverImage extends StatelessWidget {
  const SeriesCoverImage({Key? key, required this.ser}) : super(key: key);
  final SeriesController ser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ser.pickImage(context),
      child: Container(
        width: 200,
        height: 260,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderL1),
        ),
        child: SizedBox.expand(
          child: Obx(() {
            if (ser.image.value != null) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  ser.image.value!,
                  fit: BoxFit.cover,
                ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.image, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text("Upload Cover", style: TextStyle(color: Colors.white)),
              ],
            );
          }),
        ),
      ),
    );
  }
}

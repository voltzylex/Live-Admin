// widgets/series_text_fields.dart
import 'package:flutter/material.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';

class SeriesTextFields extends StatelessWidget {
  const SeriesTextFields({Key? key, required this.ser}) : super(key: key);
  final SeriesController ser;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Series Name",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextField(
            controller: ser.seriesNameController,
            decoration: InputDecoration(
              hintText: "Enter series name",
              filled: true,
              fillColor: AppColors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderL1),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text("Series Description",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextField(
            controller: ser.descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Enter series description",
              filled: true,
              fillColor: AppColors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.borderL1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

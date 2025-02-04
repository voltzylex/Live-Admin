// widgets/series_details.dart
import 'package:flutter/material.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';
import 'package:live_admin/app/modules/home/series/widgets/series_text_field.dart';

import 'series_cover_image.dart';

class SeriesDetails extends StatelessWidget {
  const SeriesDetails({super.key, required this.ser});
  final SeriesController ser;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeriesCoverImage(ser: ser),
        const SizedBox(width: 40),
        SeriesTextFields(ser: ser),
      ],
    );
  }
}

// add_series_page.dart
import 'package:flutter/material.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';
import 'package:live_admin/app/modules/home/series/widgets/action_module.dart';
import 'package:live_admin/app/modules/home/series/widgets/season_section.dart';
import 'package:live_admin/app/modules/home/series/widgets/series_details.dart';


class AddSeriesPage extends StatelessWidget {
  const AddSeriesPage({super.key, required this.ser});
  final SeriesController ser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.content,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: kContentRadius, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SeriesDetails(ser: ser),
            const SizedBox(height: 30),
            SeasonsSection(ser: ser),
            const SizedBox(height: 40),
            ActionButtons(ser: ser),
          ],
        ),
      ),
    );
  }
}

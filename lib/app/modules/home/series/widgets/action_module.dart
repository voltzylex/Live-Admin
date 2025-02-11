// widgets/action_buttons.dart
import 'dart:developer';

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';
import 'package:live_admin/app/modules/home/series/views/series_page.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.ser,
    this.isEdit = false,
    this.id,
  }) : assert(!isEdit || id != null, "If isEdit is true, id must be provided");

  final SeriesController ser;
  final bool isEdit;
  final int? id; // Optional, but required when isEdit is true

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            if (isEdit) {
              Get.find<DashboardController>().changePage(SeriesPage.name);
            } else {
              ser.isUpload.toggle();
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.borderL1,
            backgroundColor: AppColors.content,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadius),
              side: BorderSide(color: AppColors.borderL1),
            ),
          ),
          child: const Text("Cancel"),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            log("Is Season empty ${ser.addSeasons.length} : is empty ${ser.addSeasons.isEmpty}");
            // First, check if there are any seasons added.
            // ignore: invalid_use_of_protected_member
            if (ser.addSeasons.value.isEmpty) {
              ToastHelper.showToast(
                context: context,
                title: "Validation Error",
                description: "Please add at least one season before saving.",
                type: ToastType.error,
              );
              return;
            }

            // Then, check that each season has at least one episode.
            final seasonWithoutEpisode =
                ser.addSeasons.any((season) => season.episodes.isEmpty);
            if (seasonWithoutEpisode) {
              ToastHelper.showToast(
                context: context,
                title: "Validation Error",
                description:
                    "Please add at least one episode to each season before saving.",
                type: ToastType.error,
              );
              return;
            }

            // If validation passes, proceed to save the series.
            isEdit
                ? ser.editSeriesApi(context, id ?? 0)
                : ser.saveSeries(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadius),
            ),
          ),
          child: const Text("Save", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

// widgets/seasons_section.dart
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';
import 'package:live_admin/app/modules/home/series/widgets/season_card.dart';



class EditSeasonsSection extends StatelessWidget {
  const EditSeasonsSection({super.key, required this.ser});
  final SeriesController ser;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Edit Seasons and Episodes",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          const SizedBox(height: 10),
          for (int seasonIndex = 0;
              seasonIndex < ser.addSeasons.length;
              seasonIndex++)
            SeasonCard(ser: ser, seasonIndex: seasonIndex),
          TextButton.icon(
            onPressed: () => ser.addSeason(context),
            icon: const Icon(Icons.add, color: AppColors.primary),
            label: const Text("Add Season"),
          ),
        ],
      );
    });
  }
}

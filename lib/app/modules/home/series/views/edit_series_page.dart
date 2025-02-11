import 'dart:developer';

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';
import 'package:live_admin/app/modules/home/series/models/add_series_model.dart';
import 'package:live_admin/app/modules/home/series/models/single_series_model..dart';
import 'package:live_admin/app/modules/home/series/views/series_page.dart';
import 'package:live_admin/app/modules/home/series/widgets/Edit/edit_season_section.dart';
import 'package:live_admin/app/modules/home/series/widgets/action_module.dart';
import 'package:live_admin/app/modules/home/series/widgets/series_details.dart';
import 'package:live_admin/app/utils/loading.dart';

class EditSeriesPage extends StatefulWidget {
  static const String name = "/EditSeries";
  const EditSeriesPage({super.key});

  @override
  State<EditSeriesPage> createState() => _EditSeriesPageState();
}

class _EditSeriesPageState extends State<EditSeriesPage> {
  // Future that fetches the series data.
  Future<SingleSeriesModel?>? futureSeries;

  final SeriesController ser = SeriesController().to;

  @override
  void initState() {
    super.initState();
    futureSeries = _fetchSeries();
  }

  /// Fetch series and update the controller fields.
  Future<SingleSeriesModel?> _fetchSeries() async {
    try {
      final seriesData = await ser.getSeriesById(ser.id ?? 0);
      if (seriesData != null) {
        ser.editSeries.value = seriesData;

        // Update the series details in the controller.
        ser.seriesNameController.text = seriesData.series?.title ?? '';
        ser.descriptionController.text = seriesData.series?.description ?? '';

        // Convert each season from the fetched series into an AddSeason object.
        final seasons = seriesData.series!.seasons.map((s) {
          return AddSeason(
            key: GlobalKey<FormState>(),
            seasonNumber: s.seasonNumber,
            description: s.description ?? "",
            image: null, // Image will be picked later via UI
            episodes: s.episodes.map((e) {
              return AddEpisode(
                key: GlobalKey<FormState>(),
                episodeUrlController:
                    TextEditingController(text: e.episodeUrl ?? ""),
                descriptionController:
                    TextEditingController(text: e.description),
                titleController: TextEditingController(text: e.title),
                description: e.description,
                episodeNumber: e.episodeNumber,
                episodeUrl: e.episodeUrl ?? "",
                title: e.title,
                thumbnail: e.imageUrl,
              );
            }).toList(),
          );
        }).toList();
        ser.addSeasons.value = List.from(seasons);
      }
      return seriesData;
    } catch (e) {
      log("Error fetching series: $e");
      rethrow; // Let FutureBuilder handle the error.
    }
  }

  @override
  void dispose() {
    ser.clearField();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.content,
      body: FutureBuilder<SingleSeriesModel?>(
        future: futureSeries,
        builder: (context, snapshot) {
          // While waiting for the data, show a loading indicator.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Loading(
              opacity: 0,
              loadingColor: AppColors.white.withOpacity(.8),
              loadingType: LoadingType.dualRing,
            ));
          }
          // If there is an error, show an error message.
          else if (snapshot.hasError) {
            return Center(
              child: Column(
                spacing: 10,
                children: [
                  Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(color: Colors.red),
                  ),
                  backButton(),
                ],
              ),
            );
          }
          // If no data is returned, display a message.
          else if (!snapshot.hasData) {
            return Center(
                child: Column(
              spacing: 10,
              children: [
                Text("No series data available"),
                backButton(),
              ],
            ));
          }

          // Once the data is loaded, build the main UI.
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: kContentRadius, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SeriesDetails(
                  ser: ser,
                  isEditing: true,
                ),
                const SizedBox(height: 30),
                EditSeasonsSection(ser: ser),
                const SizedBox(height: 40),
                ActionButtons(
                  ser: ser,
                  isEdit: true,
                  id: ser.id,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ElevatedButton backButton() {
    return ElevatedButton(
      onPressed: () {
        Get.find<DashboardController>().changePage(SeriesPage.name);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.borderL1,
        backgroundColor: AppColors.content,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadius),
          side: BorderSide(color: AppColors.borderL1),
        ),
      ),
      child: const Text("Go Back"),
    );
  }
}

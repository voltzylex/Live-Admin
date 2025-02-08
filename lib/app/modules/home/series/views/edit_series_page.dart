import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';
import 'package:live_admin/app/modules/home/series/models/add_series_model.dart';
import 'package:live_admin/app/modules/home/series/models/single_series_model..dart';
import 'package:live_admin/app/modules/home/series/widgets/Edit/edit_season_section.dart';
import 'package:live_admin/app/modules/home/series/widgets/series_details.dart';

class EditSeriesPage extends StatefulWidget {
  const EditSeriesPage({super.key, required this.ser});
  final SeriesController ser;

  @override
  State<EditSeriesPage> createState() => _EditSeriesPageState();
}

class _EditSeriesPageState extends State<EditSeriesPage> {
  SingleSeriesModel? series;
  @override
  void initState() {
    super.initState();
    fetchSeries();
  }

  fetchSeries() async {
    series = await widget.ser.getSeriesById(Get.arguments ?? 1);
    if (series != null) {
      final ser = widget.ser;
      ser.editSeries.value = series;

      // Show error or handle null value
      ser.seriesNameController.text = series?.series?.title ?? '';
      ser.descriptionController.text = series?.series?.description ?? '';
      final d = series!.series!.seasons
          .map((s) => AddSeason(
              seasonNumber: s.seasonNumber,
              description: "",
              image: null,
              episodes: s.episodes
                  .map((e) => AddEpisode(
                        key: GlobalKey(),
                        description: e.description,
                        episodeNumber: e.episodeNumber,
                        episodeUrl: e.episodeUrl,
                        title: e.title,
                        thumbnail: e.imageUrl,
                      ))
                  .toList()))
          .toList();
      ser.addSeasons.value = List.from(d);
    }
  }

  @override
  void dispose() {
    widget.ser.clearField();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ser = widget.ser;
    return Scaffold(
      backgroundColor: AppColors.content,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: kContentRadius, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SeriesDetails(
              ser: widget.ser,
              isEditing: true,
            ),
            const SizedBox(height: 30),
            EditSeasonsSection(ser: ser),
            // const SizedBox(height: 40),
            // ActionButtons(ser: ser),
          ],
        ),
      ),
    );
  }
}

// widgets/episode_card.dart
import 'dart:convert';

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';

class EpisodeCard extends StatefulWidget {
  const EpisodeCard({
    super.key,
    required this.ser,
    required this.seasonIndex,
    required this.episodeIndex,
  });

  final SeriesController ser;
  final int seasonIndex;
  final int episodeIndex;

  @override
  State<EpisodeCard> createState() => _EpisodeCardState();
}

class _EpisodeCardState extends State<EpisodeCard> {
  // Each episode card has its own form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ser = widget.ser;
    final seasonIndex = widget.seasonIndex;
    final episodeIndex = widget.episodeIndex;

    return Card(
      color: AppColors.white.withOpacity(0.2),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Form(
        key: _formKey,
        child: ListTile(
          leading: GestureDetector(
            onTap: () =>
                ser.pickEpisodeImage(context, seasonIndex, episodeIndex),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                image: ser.addSeasons[seasonIndex].episodes[episodeIndex]
                            .thumbnail !=
                        null
                    ? DecorationImage(
                        image: MemoryImage(
                          base64Decode(ser.addSeasons[seasonIndex]
                              .episodes[episodeIndex].thumbnail!),
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: const Icon(Icons.image, color: Colors.grey),
            ),
          ),
          contentPadding: const EdgeInsets.all(5),
          title: Padding(
            padding: const EdgeInsets.all(5),
            child: TextFormField(
              controller:
                  ser.getEpisodeTitleController(seasonIndex, episodeIndex),
              decoration: const InputDecoration(
                hintText: "Episode Title",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Episode title is required";
                }
                return null;
              },
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(5),
            child: TextFormField(
              controller: ser.getEpisodeDescriptionController(
                  seasonIndex, episodeIndex),
              decoration: const InputDecoration(
                hintText: "Episode Description",
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Episode description is required";
                }
                return null;
              },
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => ser.removeEpisode(seasonIndex, episodeIndex),
          ),
        ),
      ),
    );
  }
}

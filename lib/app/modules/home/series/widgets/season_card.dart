// widgets/season_card.dart
import 'dart:convert';

import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';

import 'episode_card.dart';

class SeasonCard extends StatelessWidget {
  const SeasonCard({super.key, required this.ser, required this.seasonIndex});
  final SeriesController ser;
  final int seasonIndex;

  @override
  Widget build(BuildContext context) {
    final season = ser.addSeasons[seasonIndex];
    return Card(
      color: AppColors.white.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: season.key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Season Header Row (Title & Delete Button)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Season ${seasonIndex + 1}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => ser.removeSeason(seasonIndex),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Row with Season Image and Season Description
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Season Image Container
                  GestureDetector(
                    onTap: () => ser.pickSeasonImage(context, seasonIndex),
                    child: Container(
                      width: 100,
                      height: (MediaQuery.sizeOf(context).height / 5) - 20,
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.borderL1),
                        image: season.image != null
                            ? DecorationImage(
                                image: MemoryImage(base64Decode(season.image!)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: season.image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.image,
                                    color: Colors.white, size: 40),
                                SizedBox(height: 10),
                                Text(
                                  "Upload Image",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Season Description Text Field
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(),
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Season Description",
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: "Enter season description",
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: AppColors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.borderL1),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a season description";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              // If image is not provided, show an error message below the image field
              if (season.image == null)
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    "Please upload a season image",
                    style: TextStyle(color: Colors.red[300], fontSize: 12),
                  ),
                ),
              const SizedBox(height: 10),
              // Episodes List
              if (season.episodes.isNotEmpty)
                for (int episodeIndex = 0;
                    episodeIndex < season.episodes.length;
                    episodeIndex++)
                  EpisodeCard(
                    ser: ser,
                    seasonIndex: seasonIndex,
                    episodeIndex: episodeIndex,
                  ),
              // Button to add a new Episode
              TextButton.icon(
                onPressed: () => ser.addEpisode(seasonIndex),
                icon: const Icon(Icons.add, color: AppColors.primary),
                label: const Text("Add Episode"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

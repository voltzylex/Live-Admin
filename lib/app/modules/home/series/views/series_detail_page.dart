import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/models/series_model.dart';

class SeriesDetailPage extends StatelessWidget {
  final Series series;

  const SeriesDetailPage({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(series.title),
        backgroundColor: AppColors.primaryDark, // Use theme color
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Section
            Stack(
              children: [
                Image.network(
                  series.poster,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.black.withOpacity(0.7),
                        AppColors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Title and Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    series.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white, // Light text color for dark theme
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    series.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.lightGrey, // Softer text color
                    ),
                  ),
                ],
              ),
            ),

            // Seasons List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Seasons",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.teal,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: series.seasons.length,
              itemBuilder: (context, seasonIndex) {
                final season = series.seasons[seasonIndex];
                return SeasonWidget(season: season);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SeasonWidget extends StatelessWidget {
  final Season season;

  const SeasonWidget({super.key, required this.season});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: AppColors.table1, // Dark theme background for tile
      collapsedBackgroundColor: AppColors.table2, // Collapsed state color
      title: Text(
        "Season ${season.seasonNumber}",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
      children: season.episodes.map((episode) {
        return ListTile(
          tileColor: AppColors.contentBox, // Dark theme tile color
          leading: const Icon(Icons.play_circle_fill, color: AppColors.teal),
          title: Text(
            "Episode ${episode.episodeNumber}: ${episode.title}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          subtitle: Text(
            episode.description,
            style: TextStyle(color: AppColors.lightGrey),
          ),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 16, color: AppColors.white),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EpisodeDetailPage(episode: episode),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class EpisodeDetailPage extends StatelessWidget {
  final Episode episode;

  const EpisodeDetailPage({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Episode ${episode.episodeNumber}"),
        backgroundColor: AppColors.primaryDark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Episode Title
            Text(
              episode.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Episode Description
            Text(
              episode.description,
              style: TextStyle(fontSize: 16, color: AppColors.lightGrey),
            ),
            const SizedBox(height: 20),
            // Episode Links
            ElevatedButton.icon(
              onPressed: () {
                // Play Trailer
              },
              icon: const Icon(Icons.video_library),
              label: const Text("Watch Trailer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.teal,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Play Episode
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text("Watch Episode"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

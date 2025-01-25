import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';

class AddSeriesPage extends StatefulWidget {
  const AddSeriesPage({super.key, required this.ser});
  final SeriesController ser;

  @override
  State<AddSeriesPage> createState() => _AddSeriesPageState();
}

class _AddSeriesPageState extends State<AddSeriesPage> {
  @override
  Widget build(BuildContext context) {
    final ser = widget.ser;
    final double screenWidth = Get.width;

    return Scaffold(
      backgroundColor: AppColors.content,
      // appBar: AppBar(
      //   backgroundColor: AppColors.primary,
      //   leading: IconButton(
      //     onPressed: () => ser.isUpload.toggle(),
      //     icon: const Icon(Icons.navigate_before, color: Colors.white),
      //   ),
      //   title: const Text(
      //     "Add Series",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            // horizontal: screenWidth * 0.1,
            horizontal: kContentRadius,
            vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Series Details (Image and Text Inputs)
            seriesDetails(ser),
            const SizedBox(height: 30),

            // Add Seasons
            seasonsSection(ser),
            const SizedBox(height: 40),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Cancel Button
                ElevatedButton(
                  onPressed: () => ser.isUpload.toggle(),
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

                // Save Button with Validation
                ElevatedButton(
                  onPressed: () {
                    if (ser.seasons.isEmpty) {
                      Get.snackbar(
                        "Validation Error",
                        "Please add at least one season before saving.",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }
                    // Save logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadius),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget seriesDetails(SeriesController ser) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Upload
        GestureDetector(
          onTap: () => ser.pickImage(context),
          child: Container(
            width: 200,
            height: 260,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderL1),
            ),
            child: SizedBox.expand(
              child: Obx(() {
                if (ser.image.value != null) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      ser.image.value!,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.image, color: Colors.white, size: 40),
                    SizedBox(height: 10),
                    Text(
                      "Upload Cover",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        const SizedBox(width: 40),

        // Text Fields for Series Name and Description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Series Name",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
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
              const Text(
                "Series Description",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
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
        ),
      ],
    );
  }

  Widget seasonsSection(SeriesController ser) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add Seasons and Episodes",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),

          // Display Seasons
          for (int seasonIndex = 0;
              seasonIndex < ser.seasons.length;
              seasonIndex++)
            Card(
              color: AppColors.white.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Season ${seasonIndex + 1}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => ser.removeSeason(seasonIndex),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Episodes Section for Each Season
                    if (ser.seasons[seasonIndex].episodes.isNotEmpty)
                      for (int episodeIndex = 0;
                          episodeIndex <
                              ser.seasons[seasonIndex].episodes.length;
                          episodeIndex++)
                        Card(
                          color: AppColors.white.withOpacity(.2),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () => ser.pickEpisodeImage(
                                  context, seasonIndex, episodeIndex),
                              child: Container(
                                width: 60,
                                height: 60,
                                color: AppColors.primary.withOpacity(0.1),
                                child:
                                    const Icon(Icons.image, color: Colors.grey),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(5),
                            title: TextField(
                              // controller: ser.getEpisodeTitleController(
                              //     seasonIndex, episodeIndex),
                              decoration: const InputDecoration(
                                  hintText: "Episode Title"),
                            ).paddingAll(5),
                            subtitle: TextField(
                              // controller: ser.getEpisodeDescriptionController(
                              //     seasonIndex, episodeIndex),
                              decoration: const InputDecoration(
                                hintText: "Episode Description",
                              ),
                              maxLines: 3,
                            ).paddingAll(5),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  ser.removeEpisode(seasonIndex, episodeIndex),
                            ),
                          ),
                        ),
                    TextButton.icon(
                      onPressed: () => ser.addEpisode(seasonIndex),
                      icon: const Icon(Icons.add, color: AppColors.primary),
                      label: const Text("Add Episode"),
                    ),
                  ],
                ),
              ),
            ),

          // Add Season Button
          TextButton.icon(
            onPressed: ser.addSeason,
            icon: const Icon(Icons.add, color: AppColors.primary),
            label: const Text("Add Season"),
          ),
        ],
      );
    });
  }
}

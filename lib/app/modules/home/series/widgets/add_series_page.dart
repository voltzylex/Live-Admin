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
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () => ser.isUpload.toggle(),
          icon: const Icon(Icons.navigate_before, color: Colors.white),
        ),
        title: const Text(
          "Add Series",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Upload Section and Input Fields
            seriesDetails(ser, context),
            const SizedBox(height: 40),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Cancel Button
                ElevatedButton(
                  onPressed: () {
                    ser.isUpload.toggle();
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

                // Save Button
                ElevatedButton(
                  onPressed: () {},
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

  SizedBox seriesDetails(SeriesController ser, BuildContext context) {
    return SizedBox(
      height: 260,
      width: Get.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Upload Container
          GestureDetector(
            onTap: () => ser.pickImage(context),
            child: Container(
              // height: 250,
              width: 200,
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

          // Input Fields
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Series Name Field
                Text(
                  "Series Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: ser.seriesNameController,
                  decoration: InputDecoration(
                    hintText: "Enter series name",
                    filled: true,
                    fillColor: AppColors.white.withOpacity(0.1),
                  ),
                ),
                const SizedBox(height: 10),

                // Series Description Field
                Text(
                  "Series Description",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: ser.descriptionController,
                  maxLines: 5,
                  // minLines: 4,
                  decoration: InputDecoration(
                    hintText: "Enter series description",
                    filled: true,
                    fillColor: AppColors.white.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

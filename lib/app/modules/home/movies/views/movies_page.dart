import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/themes/app_text_theme.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title - Upload Movie
          Text(
            'Upload Movie',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ).paddingAll(20),
          const SizedBox(height: 16),
          SizedBox(
            width: Get.width,
            child: ColoredBox(
              // ignore: deprecated_member_use
              color: AppColors.white.withOpacity(.08),
              child: Text(
                "Movie Details",
              ).paddingOnly(left: 20, top: 5, bottom: 5),
            ),
          ),
          const SizedBox(height: 16),
          // Upload Cover
          Container(
            margin: EdgeInsets.only(left: 20),
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColors.white),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image),
                SizedBox(width: 10),
                Text("Upload Cover"),
              ],
            ),
          ),
          // Movie Details Box
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              // color: Colors.grey[800], // Light grey background color
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Name field
                Text('Movie Name', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: ' movie name',
                  ),
                ),
                const SizedBox(height: 16),

                // Category and Type Row
                Row(
                  children: [
                    // Category Dropdown
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Category',
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: AppColors.hintText),
                              labelText: 'Select category',
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'Action',
                                child: Text('Action'),
                              ),
                              DropdownMenuItem(
                                value: 'Drama',
                                child: Text('Drama'),
                              ),
                              // Add more categories here
                            ],
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Type Dropdown
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Type', style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: AppColors.hintText),
                              labelText: 'Movie type',
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'Feature',
                                child: Text('Feature'),
                              ),
                              DropdownMenuItem(
                                value: 'Short',
                                child: Text('Short'),
                              ),
                              // Add more types here
                            ],
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Upload Link field
                Text('Upload Link', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'upload link',
                  ),
                ),
                const SizedBox(height: 16),

                // Movie Description field
                Text('Movie Description',
                    style: TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write description',
                  ),
                ),
                const SizedBox(height: 16),

                // Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Cancel Button
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.borderL1,
                        backgroundColor: AppColors.content,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: AppColors.borderL1)),
                      ),
                      child: Text('Cancel'),
                    ),
                    const SizedBox(width: 16),
                    // Publish Button
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        // foregroundColor: AppColors.primary, // Primary color
                        // backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        AppStrings.save,
                        style: AppTextStyles.base.whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

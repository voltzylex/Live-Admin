import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/models/add_movie_model.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';
import 'package:live_admin/app/modules/home/series/widgets/series_list_page.dart';
import 'package:live_admin/app/themes/app_text_theme.dart';

class SeriesPage extends StatelessWidget {
  const SeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ser = Get.put(SeriesController());

    // Form key for validation
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Obx(() {
      if (!ser.isUpload.value) {
        return SeriesListPage(
          series: ser,
        );
      }
      return Scaffold(
        backgroundColor: AppColors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title - Upload Movie
                Text(
                  'Upload Movie',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).paddingAll(20),
                const SizedBox(height: 16),
                SizedBox(
                  width: Get.width,
                  child: ColoredBox(
                    color: AppColors.white.withOpacity(.08),
                    child: Text(
                      "Movie Details",
                    ).paddingOnly(left: 20, top: 5, bottom: 5),
                  ),
                ),
                const SizedBox(height: 16),

                // Upload Cover
                InkWell(
                  onTap: () {
                    ser.pickImage(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    height: 150,
                    width: Get.width / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: AppColors.white),
                    ),
                    child: Obx(() {
                      if (ser.image.value != null) {
                        return Image.memory(
                          ser.image.value!,
                          fit: BoxFit.contain,
                        );
                      }
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image),
                          SizedBox(width: 10),
                          Text("Upload Cover"),
                        ],
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 16),

                // Movie Details Box
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie Name field
                      Text('Movie Name', style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: ser.movieNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter movie name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a movie name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      const SizedBox(height: 16),

                      // Upload Link field
                      Text('Movie Link', style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: ser.uploadLinkController,
                        decoration: InputDecoration(
                          hintText: 'Enter Movie link',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Movie link cannot be empty";
                          }
                          if (value.isEmpty || (!value.isURL)) {
                            return 'Please enter a valid link';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Movie Description field
                      Text('Movie Description',
                          style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: ser.descriptionController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Enter movie description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Buttons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Cancel Button
                          ElevatedButton(
                            onPressed: () {
                              formKey.currentState?.reset();
                              ser.isUpload.toggle();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.borderL1,
                              backgroundColor: AppColors.content,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(kRadius),
                                  side: BorderSide(color: AppColors.borderL1)),
                            ),
                            child: Text('Cancel'),
                          ),
                          SizedBox(width: 16),

                          // Publish Button
                          ElevatedButton(
                            onPressed: () async {
                              log("Auth header : ${await ApiConnect.instance.authHeader()}");
                              // mov.isSubmitPressed.value = true;

                              if ((formKey.currentState?.validate() ?? false) &&
                                  ser.categoryController.text.isNotEmpty &&
                                  ser.typeController.text.isNotEmpty) {
                                final movie = AddMovie(
                                    title: ser.movieNameController.text,
                                    poster: kDebugMode
                                        ? "this is image link"
                                        : base64Encode(ser.image.value!),
                                    movieUrl: ser.uploadLinkController.text,
                                    categories: [ser.categoryController.text],
                                    tags: [ser.typeController.text]);
                                log("Movie ${movie.toJson()}");
                                await ser.uploadMovie(
                                  context,
                                  movie,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(kRadius),
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
          ),
        ),
      );
    });
  }
}
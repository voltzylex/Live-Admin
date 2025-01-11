import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';
import 'package:live_admin/app/modules/home/movies/models/add_movie_model.dart';
import 'package:live_admin/app/modules/home/movies/models/movies_model.dart';
import 'package:live_admin/app/modules/home/movies/widgets/category_widget.dart';
import 'package:live_admin/app/modules/home/movies/widgets/type_widget.dart';
import 'package:live_admin/app/themes/app_text_theme.dart';

class AddMovieBody extends StatefulWidget {
  const AddMovieBody(
      {super.key, required this.mov, this.isEdit = false, this.movies});
  final MoviesController mov;
  final bool isEdit;
  final Movie? movies;

  @override
  State<AddMovieBody> createState() => _AddMovieBodyState();
}

class _AddMovieBodyState extends State<AddMovieBody> {
  @override
  void initState() {
    super.initState();
    if (widget.isEdit) setData();
  }

  @override
  void dispose() {
    clearData();
    super.dispose();
  }

  setData() {
    widget.mov.movieNameController.text = widget.movies!.title;
    widget.mov.descriptionController.text = widget.movies!.description;
    widget.mov.uploadLinkController.text = widget.movies!.movieUrl;

    widget.mov.selectedCategories
        .addAll(widget.movies!.categories.map((e) => e.name).toList());
    widget.mov.selectedTypes
        .addAll(widget.movies!.tags.map((e) => e.name).toList());
  }

  clearData() {
    widget.mov.movieNameController.clear();
    widget.mov.descriptionController.clear();
    widget.mov.uploadLinkController.clear();
    widget.mov.selectedTypes.clear();
    widget.mov.selectedCategories.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Form key for validation
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                widget.isEdit ? "Edit Movie" : 'Upload Movie',
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
                  widget.mov.pickImage(context);
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
                    if (widget.mov.image.value != null) {
                      return Image.memory(
                        widget.mov.image.value!,
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
                      controller: widget.mov.movieNameController,
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

                    // Category and Type Row
                    Row(
                      children: [
                        // Category TypeAhead Field
                        Expanded(
                            child: CategoryWidget(
                          categoryController: widget.mov.categoryController,
                          mov: widget.mov,
                        )),
                        const SizedBox(width: 16),
                        // Type TypeAhead Field
                        Expanded(
                          child: TypeWidget(
                            typeController: widget.mov.typeController,
                            mov: widget.mov,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Upload Link field
                    Text('Movie Link', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: widget.mov.uploadLinkController,
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
                      controller: widget.mov.descriptionController,
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
                            if (widget.isEdit) {
                              clearData();
                              Get.back();
                              return;
                            }
                            formKey.currentState?.reset();
                            widget.mov.isUpload.toggle();
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

                            if ((formKey.currentState?.validate() ?? false)) {
                              final movie = AddMovie(
                                  title: widget.mov.movieNameController.text,
                                  poster: kDebugMode
                                      ? "this is image link"
                                      : base64Encode(widget.mov.image.value!),
                                  movieUrl:
                                      widget.mov.uploadLinkController.text,
                                  categories: widget.mov.selectedCategories,
                                  tags: widget.mov.selectedTypes);
                              log("Movie ${movie.toJson()}");
                              await widget.mov.uploadMovie(
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
  }
}

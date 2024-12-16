import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/controllers/movies_controller.dart';
import 'package:live_admin/app/modules/home/movies/widgets/category_widget.dart';
import 'package:live_admin/app/modules/home/movies/widgets/type_widget.dart';
import 'package:live_admin/app/themes/app_text_theme.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mov = Get.put(MoviesController());
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController typeController = TextEditingController();
    final TextEditingController movieNameController = TextEditingController();
    final TextEditingController uploadLinkController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

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
                  mov.pickImage(context);
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
                    if (mov.image.value != null) {
                      return Image.memory(
                        mov.image.value!,
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
                      controller: movieNameController,
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
                          categoryController: categoryController,
                        )),
                        const SizedBox(width: 16),
                        // Type TypeAhead Field
                        Expanded(
                          child: TypeWidget(typeController: typeController),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Upload Link field
                    Text('Upload Link', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: uploadLinkController,
                      decoration: InputDecoration(
                        hintText: 'Enter upload link',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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
                      controller: descriptionController,
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
                          },
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
                          onPressed: () {
                            // mov.isSubmitPressed.value = true;
                            if (formKey.currentState?.validate() ??
                                false &&
                                    categoryController.text.isNotEmpty &&
                                    typeController.text.isNotEmpty) {
                              // Perform save or publish logic
                              // mov.saveMovie(
                              //   movieName: movieNameController.text,
                              //   category: categoryController.text,
                              //   type: typeController.text,
                              //   uploadLink: uploadLinkController.text,
                              //   description: descriptionController.text,
                              // );
                            }
                          },
                          style: ElevatedButton.styleFrom(
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
        ),
      ),
    );
  }
}

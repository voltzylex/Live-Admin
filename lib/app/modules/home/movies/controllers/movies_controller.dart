import 'dart:developer';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/models/add_movie_model.dart';
import 'package:live_admin/app/modules/home/movies/models/movies_model.dart';
import 'package:live_admin/app/utils/constants.dart';

class MoviesController extends GetxController with StateMixin<MoviesModel> {
  MoviesController get to => Get.isRegistered<MoviesController>()
      ? Get.find<MoviesController>()
      : Get.put(MoviesController());
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController movieNameController = TextEditingController();
  final TextEditingController uploadLinkController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Rxn<Uint8List> image = Rxn();
  final picker = ImagePicker();
  final type = movieTypes;
  final category = movieCategories;
  RxBool isSwitchOn = true.obs;
  RxString selectedCategory = ''.obs;
  RxString selectedType = ''.obs;
  final List<String> selectedCategories = [];
  final List<String> selectedTypes = []; // Stores selected types
  RxBool isUpload = false.obs;
  // RxList<Movie> movies = <Movie>[].obs;
  final PaginatorController pageController = PaginatorController();
  RxInt currenP = 1.obs;

  @override
  onClose() {
    clearField();
    super.onClose();
  }

  @override
  onInit() {
    super.onInit();
    getMovies(1);
    ever(
      currenP,
      (callback) {
        log("Callback is $callback");
        if (callback != (state?.meta?.currentPage ?? 0)) {
          getMovies(callback);
        }
      },
    );
  }

  clearField() {
    categoryController.text = "";
    typeController.text = "";
    movieNameController.clear();
    uploadLinkController.clear();
    descriptionController.clear();
    image(null);
    selectedCategory("");
    selectedType("");
    isUpload(false);
  }

  // Add movies-specific logic here.
  Future<void> pickImage(BuildContext context) async {
    // For mobile (Android, iOS), use ImagePicker
    // For web, use ImagePickerWeb

    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image.value = Uint8List.fromList(await img.readAsBytes());
    } else {
      ToastHelper.showToast(
        context: context,
        title: 'Please Select Image',
        description: 'please select image before proceding!',
        type: ToastType.error,
      );
    }
  }

  uploadMovie(BuildContext context, AddMovie movie) async {
    if (image.value == null) {
      ToastHelper.showToast(
        context: context,
        title: 'Please Select Image',
        description: 'please select image before proceding!',
        type: ToastType.error,
      );
      return;
    }

    try {
      showLoading();
      await ApiConnect.instance.addMovie(movie);
      ToastHelper.showToast(
        context: context,
        title: 'Movie Uploaded Succesfully',
        description: "",
        type: ToastType.success,
      );
      clearField();
      getMovies(currenP.value);
      hideLoading();
    } catch (e) {
      ToastHelper.showToast(
        context: context,
        title: 'Server Error',
        description: e.toString(),
        type: ToastType.error,
      );
      hideLoading();
    }
  }

  Future<void> getMovies(int? page) async {
    try {
      change(null, status: RxStatus.loading()); // Set loading state
      final res = await ApiConnect.instance.getMovies(page ?? 1);
      final mov = MoviesModel.fromJson(res.body);
      // movies.addAll(mov.movies);
      change(mov, status: RxStatus.success());
    } catch (e) {
      // Set error state
      change(null, status: RxStatus.error('Failed to load data'));
    }
  }

  Future<void> deleteMovie(int id, BuildContext context) async {
    try {
      final res = await ApiConnect.instance.deleteMovie(id);
      if (res.statusCode == 200) {
        state!.movies.removeWhere(
          (element) => element.id == id,
        );
        update();
        ToastHelper.showToast(
          context: context,
          title: 'Deleted Succesfully',
          description: res.body["message"] ?? 'Movie Deleted Succesfully',
          type: ToastType.error,
        );
      }
    } catch (e) {
      ToastHelper.showToast(
        context: context,
        title: 'Some error occured',
        description: e.toString(),
        type: ToastType.error,
      );
    }
  }
  // Edit movie

  editMovie(BuildContext context, AddMovie movie, int id) async {
    final m = movie.toJson();

    m.remove("poster");
    log("Edit data is $m");
    return;
    // if (image.value == null) {
    //   ToastHelper.showToast(
    //     context: context,
    //     title: 'Please Select Image',
    //     description: 'please select image before proceding!',
    //     type: ToastType.error,
    //   );
    //   return;
    // }

    try {
      showLoading();
      await ApiConnect.instance.updateMovie(id, movie);
      ToastHelper.showToast(
        context: context,
        title: 'Movie Updated Succesfully',
        description: "",
        type: ToastType.success,
      );
      clearField();
      getMovies(currenP.value);
      hideLoading();
    } catch (e) {
      ToastHelper.showToast(
        context: context,
        title: 'Server Error',
        description: e.toString(),
        type: ToastType.error,
      );
      hideLoading();
    }
  }
}

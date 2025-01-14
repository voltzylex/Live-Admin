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

  void toggleMovieStatus(int movieId, bool status) async {
    final movieIndex = state?.movies.indexWhere((movie) => movie.id == movieId);
    if (movieIndex != null && movieIndex != -1) {
      final updatedMovies = List<Movie>.from(state!.movies);

      showLoading();
      await ApiConnect.instance.updateMovieStatus(movieId, status);
      hideLoading();
      updatedMovies[movieIndex] =
          updatedMovies[movieIndex].copyWith(status: status);
      change(state!.copyWith(movies: updatedMovies),
          status: RxStatus.success());
    }
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
      showLoading();
      final res = await ApiConnect.instance.deleteMovie(id);
      hideLoading();
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
      hideLoading();
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
    try {
      showLoading(); // Show a loading indicator while the update is in progress

      // Call API to update the movie
      await ApiConnect.instance.updateMovie(id, movie);
      await getMovies(currenP.value);
      // Find the index of the movie to be updated in the current state
      final index = state?.movies.indexWhere((element) => element.id == id);

      if (index != null && index >= 0) {
        // Create a copy of the movies list and update the specific movie
        // final updatedMovies = List<Movie>.from(state!.movies);
        // updatedMovies[index] = updatedMovies[index].copyWith(
        //   title: movie.title,
        //   description: movie.description,
        //   categories: movie.categories,
        //   tags: movie.tags,
        //   poster: movie.poster,
        //   status: movie.status,
        // );

        // Update the state with the modified movies list
        // change(state!.copyWith(movies: updatedMovies), status: RxStatus.success());

        // Show success toast
        ToastHelper.showToast(
          context: context,
          title: 'Movie Updated Successfully',
          description: "",
          type: ToastType.success,
        );

        clearField(); // Clear input fields after the operation
      } else {
        // Show an error toast if the movie is not found
        ToastHelper.showToast(
          context: context,
          title: 'Movie Not Found',
          description: "The movie you're trying to update does not exist.",
          type: ToastType.error,
        );
      }
    } catch (e) {
      // Handle any errors and show a failure toast
      ToastHelper.showToast(
        context: context,
        title: 'Server Error',
        description: e.toString(),
        type: ToastType.error,
      );
    } finally {
      hideLoading(); // Ensure loading indicator is hidden after the operation
    }
  }
}

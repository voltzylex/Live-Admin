import 'dart:developer';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/movies/models/add_movie_model.dart';
import 'package:live_admin/app/modules/home/series/models/series_model.dart';
import 'package:live_admin/app/utils/constants.dart';

class SeriesController extends GetxController with StateMixin<SeriesModel> {
  SeriesController get to => Get.isRegistered<SeriesController>()
      ? Get.find<SeriesController>()
      : Get.put(SeriesController());
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController movieNameController = TextEditingController();
  final TextEditingController uploadLinkController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Rxn<Uint8List> image = Rxn();
  final picker = ImagePicker();
  RxBool isSwitchOn = true.obs;
  RxString selectedCategory = ''.obs;
  RxString selectedType = ''.obs;
  RxBool isUpload = false.obs;

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
    getSeries(1);
    ever(
      currenP,
      (callback) {
        log("Callback is $callback");
        if (callback != (state?.meta?.currentPage ?? 0)) {
          getSeries(callback);
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

  Future<void> getSeries(int? page) async {
    try {
      change(null, status: RxStatus.loading()); // Set loading state
      final res = await ApiConnect.instance.getSeries(page ?? 1);
      final ser = SeriesModel.fromJson(res.body);

      change(ser, status: RxStatus.success());
    } catch (e) {
      // Set error state
      change(null, status: RxStatus.error('Failed to load data $e'));
    }
  }
}

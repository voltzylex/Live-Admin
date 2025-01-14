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

  // Controllers for series input
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController seriesNameController = TextEditingController();
  final TextEditingController uploadLinkController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final Rxn<Uint8List> image = Rxn(); // Series cover image
  final picker = ImagePicker();
  RxBool isSwitchOn = true.obs;
  RxString selectedCategory = ''.obs;
  RxString selectedType = ''.obs;
  RxBool isUpload = false.obs;

  // Pagination
  final PaginatorController pageController = PaginatorController();
  RxInt currenP = 1.obs;

  // Seasons and Episodes
  final RxList<Season> seasons = <Season>[].obs;

  @override
  void onClose() {
    clearField();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getSeries(1);
    ever(currenP, (callback) {
      log("Callback is $callback");
      if (callback != (state?.meta?.currentPage ?? 0)) {
        getSeries(callback);
      }
    });
  }

  // Clear all input fields
  void clearField() {
    categoryController.text = "";
    typeController.text = "";
    seriesNameController.clear();
    uploadLinkController.clear();
    descriptionController.clear();
    image(null);
    selectedCategory("");
    selectedType("");
    isUpload(false);
    seasons.clear();
  }

  // Add Season
  void addSeason() {
    seasons.add(Season(episodes: <Episode>[].obs));
  }

  // Remove Season
  void removeSeason(int seasonIndex) {
    if (seasonIndex < seasons.length) {
      seasons.removeAt(seasonIndex);
    }
  }

  // Add Episode to a specific season
  void addEpisode(int seasonIndex) {
    if (seasonIndex < seasons.length) {
      seasons[seasonIndex].episodes.add(Episode());
    }
  }

  // Remove Episode from a specific season
  void removeEpisode(int seasonIndex, int episodeIndex) {
    if (seasonIndex < seasons.length &&
        episodeIndex < seasons[seasonIndex].episodes.length) {
      seasons[seasonIndex].episodes.removeAt(episodeIndex);
    }
  }

  // Image picking for a series
  Future<void> pickImage(BuildContext context) async {
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image.value = Uint8List.fromList(await img.readAsBytes());
    } else {
      ToastHelper.showToast(
        context: context,
        title: 'Please Select Image',
        description: 'Please select an image before proceeding!',
        type: ToastType.error,
      );
    }
  }

  // Image picking for an episode
  Future<void> pickEpisodeImage(
      BuildContext context, int seasonIndex, int episodeIndex) async {
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null && seasonIndex < seasons.length) {
      final episode = seasons[seasonIndex].episodes[episodeIndex];
      episode.image = Uint8List.fromList(await img.readAsBytes());
      seasons.refresh(); // Trigger UI update
    } else {
      ToastHelper.showToast(
        context: context,
        title: 'Please Select Image',
        description: 'Please select an image before proceeding!',
        type: ToastType.error,
      );
    }
  }

  // Save Series
  Future<void> saveSeries(BuildContext context) async {
    if (image.value == null) {
      ToastHelper.showToast(
        context: context,
        title: 'Validation Error',
        description: 'Please upload a series cover image!',
        type: ToastType.error,
      );
      return;
    }
    if (seasons.isEmpty) {
      ToastHelper.showToast(
        context: context,
        title: 'Validation Error',
        description: 'Please add at least one season!',
        type: ToastType.error,
      );
      return;
    }

    try {
      showLoading();

      // Mock saving data
      log("Saving series with ${seasons.length} seasons...");
      log("Series Name: ${seriesNameController.text}");
      log("Description: ${descriptionController.text}");
      log("Seasons: ${seasons.map((s) => s.toJson()).toList()}");

      ToastHelper.showToast(
        context: context,
        title: 'Series Saved Successfully',
        description: '',
        type: ToastType.success,
      );
      clearField();
    } catch (e) {
      ToastHelper.showToast(
        context: context,
        title: 'Server Error',
        description: e.toString(),
        type: ToastType.error,
      );
    } finally {
      hideLoading();
    }
  }

  // Fetch series data (pagination)
  Future<void> getSeries(int? page) async {
    try {
      change(null, status: RxStatus.loading());
      final res = await ApiConnect.instance.getSeries(page ?? 1);
      final ser = SeriesModel.fromJson(res.body);

      change(ser, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error('Failed to load data $e'));
    }
  }
}

// Models for Season and Episode
class Season {
  RxList<Episode> episodes;

  Season({required this.episodes});

  Map<String, dynamic> toJson() {
    return {
      'episodes': episodes.map((e) => e.toJson()).toList(),
    };
  }
}

class Episode {
  Uint8List? image;
  String title = '';
  String description = '';

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'description': description,
    };
  }
}

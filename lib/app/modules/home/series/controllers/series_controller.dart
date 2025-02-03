import 'dart:developer';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/series/models/add_series_model.dart'; // Your new models
import 'package:live_admin/app/modules/home/series/models/series_model.dart';
import 'package:live_admin/app/utils/constants.dart';

class SeriesController extends GetxController with StateMixin<SeriesModel> {
  SeriesController get to => Get.isRegistered<SeriesController>()
      ? Get.find<SeriesController>()
      : Get.put(SeriesController());

  // Controllers for series input
  final TextEditingController seriesNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // Map to hold controllers for episode title and description dynamically
  final Map<int, Map<int, TextEditingController>> episodeTitleControllers = {};
  final Map<int, Map<int, TextEditingController>>
      episodeDescriptionControllers = {};
  RxBool isSwitchOn = true.obs;
  RxString selectedCategory = ''.obs;
  RxString selectedType = ''.obs;
  final Rxn<Uint8List> image = Rxn(); // Series cover image
  final picker = ImagePicker();
  RxBool isUpload = false.obs;

  // Seasons and Episodes
  final RxList<AddSeason> addSeasons = <AddSeason>[].obs;
  // Get the controller for a specific episode's title
  TextEditingController getEpisodeTitleController(
      int seasonIndex, int episodeIndex) {
    if (!episodeTitleControllers.containsKey(seasonIndex)) {
      episodeTitleControllers[seasonIndex] = {};
    }
    if (!episodeTitleControllers[seasonIndex]!.containsKey(episodeIndex)) {
      episodeTitleControllers[seasonIndex]![episodeIndex] =
          TextEditingController();
    }
    return episodeTitleControllers[seasonIndex]![episodeIndex]!;
  }

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

  // Get the controller for a specific episode's description
  TextEditingController getEpisodeDescriptionController(
      int seasonIndex, int episodeIndex) {
    if (!episodeDescriptionControllers.containsKey(seasonIndex)) {
      episodeDescriptionControllers[seasonIndex] = {};
    }
    if (!episodeDescriptionControllers[seasonIndex]!
        .containsKey(episodeIndex)) {
      episodeDescriptionControllers[seasonIndex]![episodeIndex] =
          TextEditingController();
    }
    return episodeDescriptionControllers[seasonIndex]![episodeIndex]!;
  }

  // Add Season
  void addSeason() {
    addSeasons.add(AddSeason(
        seasonNumber: seasons.length + 1,
        episodes: [],
        description: "",
        image: ""));
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
      addSeasons[seasonIndex].episodes.add(AddEpisode(
            episodeNumber: seasons[seasonIndex].episodes.length + 1,
            title: '',
            description: '',
            thumbnail: '',
          ));
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
      final episode = addSeasons[seasonIndex]
          .episodes[episodeIndex]
          .copyWith(thumbnail: img.path);
// Use image path for simplicity
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

      // Here you would send the AddSeriesModel to your backend
      final series = AddSeries(
        name: seriesNameController.text,
        description: descriptionController.text,
        coverImage: image.value != null ? 'image path or base64 data' : '',
        seasons: addSeasons,
      );

      final addSeriesModel = AddSeriesModel(series: series);

      // Send your addSeriesModel to your API to save the series

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

  void clearField() {
    seriesNameController.clear();
    descriptionController.clear();
    image(null);
    seasons.clear();
    seriesNameController.clear();

    descriptionController.clear();
    image(null);
    selectedCategory("");
    selectedType("");
    isUpload(false);
    seasons.clear();
  }

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

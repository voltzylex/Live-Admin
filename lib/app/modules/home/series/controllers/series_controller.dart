import 'dart:convert';
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
    ever(
        addSeasons,
        (callback) => log("Add season ${addSeasons.map(
              (element) => element.toJson(),
            )}"));
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
  // Add Season
  void addSeason() {
    for (var se in addSeasons) {
      if (se.key?.currentState?.validate() ?? false) {
        continue;
      } else {
        return;
      }
    }
    addSeasons.add(
      AddSeason(
        seasonNumber: addSeasons.length + 1,
        episodes: [],
        // Use a TextEditingController for the description so that the UI can bind to it
        description: "",

        key: GlobalKey<FormState>(),
        // Set image to null initially (or use your preferred default value)
        image: null,
      ),
    );
  }

  // Remove Season
  void removeSeason(int seasonIndex) {
    if (seasonIndex < addSeasons.length) {
      addSeasons.removeAt(seasonIndex);
    }
  }

  // Add Episode to a specific season
  void addEpisode(int seasonIndex) {
    if (seasonIndex < addSeasons.length) {
      addSeasons[seasonIndex].episodes.add(AddEpisode(
            episodeUrl: "",
            episodeNumber: addSeasons[seasonIndex].episodes.length + 1,
            title: '',
            description: '',
            thumbnail: '',
          ));
      addSeasons.refresh();
    }
  }

  // Remove Episode from a specific season
  void removeEpisode(int seasonIndex, int episodeIndex) {
    if (seasonIndex < addSeasons.length &&
        episodeIndex < addSeasons[seasonIndex].episodes.length) {
      addSeasons[seasonIndex].episodes.removeAt(episodeIndex);
      addSeasons.refresh();
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
    if (img != null && seasonIndex < addSeasons.length) {
      final episode = addSeasons[seasonIndex].episodes[episodeIndex].copyWith(
          thumbnail: base64Encode(Uint8List.fromList(await img.readAsBytes())));
      addSeasons[seasonIndex].episodes[episodeIndex] = episode;
// Use image path for simplicity
      addSeasons.refresh(); // Trigger UI update
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
  Future<void> pickSeasonImage(BuildContext context, int seasonIndex) async {
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null && seasonIndex < addSeasons.length) {
      final season = addSeasons[seasonIndex].copyWith(
          image: base64Encode(Uint8List.fromList(await img.readAsBytes())));
      addSeasons[seasonIndex] = season;
// Use image path for simplicity
      addSeasons.refresh(); // Trigger UI update
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
    if (addSeasons.isEmpty) {
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

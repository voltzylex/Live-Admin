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

  // Add Season
  void addSeason(BuildContext context) {
    for (var se in addSeasons) {
      if (!se.key!.currentState!.validate()) {
        return;
      }
      if (se.image == null) {
        ToastHelper.showToast(
          context: context,
          title: 'Please Select Season Image',
          description: 'Please select an image before proceeding!',
          type: ToastType.error,
        );
        return;
      }
      for (var im in se.episodes) {
        if (im.thumbnail == null) {
          ToastHelper.showToast(
            context: context,
            title: 'Please Select Episode Image',
            description: 'Please select an image before proceeding!',
            type: ToastType.error,
          );
          return;
        }
      }
    }

    addSeasons.add(
      AddSeason(
        seasonNumber: addSeasons.length + 1,
        episodes: [],
        // Use a TextEditingController for the description so that the UI can bind to it
        description: "",

        key: GlobalKey<FormState>(),
        descriptionController: TextEditingController(),
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
  void addEpisode(int seasonIndex, BuildContext context) {
    for (var ep in addSeasons[seasonIndex].episodes) {
      log("Episode ${addSeasons[seasonIndex].episodes.map((element) => element.toJson())}");
      if (!ep.key.currentState!.validate()) {
        return;
      }
      if (ep.thumbnail == null) {
        ToastHelper.showToast(
          context: context,
          title: 'Please Select Episode Image',
          description: 'Please select an image before proceeding!',
          type: ToastType.error,
        );
        return;
      }
    }

    if (seasonIndex < addSeasons.length) {
      addSeasons[seasonIndex].episodes.add(AddEpisode(
            key:
                GlobalKey<FormState>(), // Ensure a unique key is used each time
            episodeUrl: "",
            episodeNumber: addSeasons[seasonIndex].episodes.length + 1,
            title: '',
            description: '',
            thumbnail: null,
            descriptionController: TextEditingController(),
            titleController: TextEditingController(),
            episodeUrlController: TextEditingController(),
          ));

      addSeasons.refresh(); // Ensure the state is properly refreshed
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
    for (var adS in addSeasons) {
      for (var ep in adS.episodes) {
        if (!ep.key.currentState!.validate()) {
          return;
        }
        if (ep.thumbnail == null) {
          ToastHelper.showToast(
            context: context,
            title: 'Please Select Episode Image',
            description: 'Please select an image before proceeding!',
            type: ToastType.error,
          );
          return;
        }
      }
    }
    // Mock saving data
    // log("Saving series with ${addSeasons.length} seasons...");
    // log("Series Name: ${seriesNameController.text}");
    // log("Description: ${descriptionController.text}");
    // log("Seasons: ${addSeasons.map((s) => s.toJson(showImage: false)).toList()}");
    final newSeries = AddSeriesModel(
        series: AddSeries(
            name: seriesNameController.text,
            description: descriptionController.text,
            coverImage: "",
            //  base64Encode(image.value!),
            seasons: addSeasons));
    // log("Final season: ${newSeries.toJson()}");
    // return;
    try {
      showLoading();
      final res = await ApiConnect.instance.addSeries(newSeries);
      // hideLoading();
      // Send your addSeriesModel to your API to save the series
      if (res.statusCode == 200) {
        ToastHelper.showToast(
          context: context,
          title: 'Series Saved Successfully',
          description: '',
          type: ToastType.success,
        );
        getSeries(1);
        clearField();
      } else {
        ToastHelper.showToast(
          context: context,
          title: 'Server Error',
          description: res.body.toString(),
          type: ToastType.error,
        );
      }
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

import 'dart:developer';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/membership/models/add_subscribe_model.dart';
import 'package:live_admin/app/modules/home/membership/models/membership_model.dart';
import 'package:live_admin/app/modules/home/membership/models/plans_model.dart';
import 'package:live_admin/app/modules/home/membership/models/subscribe_model.dart';
import 'package:live_admin/app/modules/home/user/controllers/user_controller.dart';
import 'package:live_admin/app/utils/constants.dart';

class MembershipController extends GetxController
    with StateMixin<MembershipModel> {
  MembershipController get to => Get.isRegistered<MembershipController>()
      ? Get.find<MembershipController>()
      : Get.put(MembershipController());
  final TextEditingController planName = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController duration = TextEditingController();
  final TextEditingController features = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Rxn<Uint8List> image = Rxn();
  final Rxn<PlansModel?> plans = Rxn<PlansModel?>();
  final picker = ImagePicker();

  User? user;
  late UserController users;
  RxBool isSwitchOn = true.obs;
  RxString selectedCategory = ''.obs;
  RxString selectedType = ''.obs;
  RxBool isMembership = false.obs;
  RxBool isPlanL = false.obs;
  // RxList<Movie> movies = <Movie>[].obs;
  final PaginatorController pageController = PaginatorController();
  RxInt currenP = 1.obs;
  @override
  onInit() {
    super.onInit();
    users = UserController.to;
    getMembers(1);
    fetchPlans();
    ever(
      currenP,
      (callback) {
        log("Callback is $callback");
        if (callback != (state?.meta?.currentPage ?? 0)) {
          getMembers(callback);
        }
      },
    );
  }

  Future<void> getMembers(int? page) async {
    try {
      change(null, status: RxStatus.loading()); // Set loading state
      final res = await ApiConnect.instance.getMemberships(page ?? 1);
      final mov = MembershipModel.fromJson(res.body);
      // movies.addAll(mov.movies);
      change(mov, status: RxStatus.success());
    } catch (e) {
      // Set error state
      change(null, status: RxStatus.error('Failed to load data'));
    }
  }

  Future<PlansModel?> fetchPlans() async {
    try {
      isPlanL.value = true;
      final plan = await ApiConnect.instance.getPlans();
      isPlanL.value = false;

      return PlansModel.fromJson(plan.body);
    } on Exception catch (e) {
      ToastHelper.showToast(
          context: Get.context!,
          title: e.toString(),
          description: "",
          type: ToastType.error);
      return null;
    }
  }

  Future<void> subscribeToPlan(
      AddSubscribeModel subscribe, BuildContext context) async {
    try {
      showLoading();
      final res = await ApiConnect.instance.subscribeToPlan(subscribe);

      final data = SubscribeModel.fromJson(res.body);
      hideLoading();
      ToastHelper.showToast(
        context: context,
        title: data.message,
        description: "",
        type: res.statusCode! <= 202 ? ToastType.success : ToastType.error,
      );
    } catch (e) {
      hideLoading();
      ToastHelper.showToast(
        context: context,
        title: "Something Went wrong",
        description: e.toString(),
        type: ToastType.error,
      );
    }
  }
}

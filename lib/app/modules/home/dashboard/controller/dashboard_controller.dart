import 'dart:developer';

import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/dashboard/models/dashboard_model.dart';
import 'package:live_admin/app/modules/home/series/controllers/series_controller.dart';
import 'package:live_admin/app/modules/home/series/views/series_page.dart';

class DashboardController extends GetxController
    with StateMixin<DashboardModel> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String? currentRoute;
  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
    ever(
      onTapTrigger,
      (callback) {
        log("Series cont called ${currentPage.value} : ");
        switch (currentPage.value) {
          case SeriesPage.name:
            () {
              log("Series cont called");
              final s = SeriesController().to;
              s.isAddSeries(false);
              s.clearField();
            };
            break;
          default:
        }
      },
    );
  }

  final RxString currentPage = '/dashboard'.obs;

  var onTapTrigger = false.obs; // This will act as a trigger
  // Update the current page
  void changePage(String page) {
    currentPage.value = page;
    onTapTrigger.value =
        !onTapTrigger.value; // Toggle value to trigger listener
  }

  // Fetch dashboard data
  Future<void> fetchDashboard() async {
    try {
      change(null, status: RxStatus.loading());
      final res = await ApiConnect.instance.getDashboard(null);
      change(DashboardModel.fromJson(res.body), status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}

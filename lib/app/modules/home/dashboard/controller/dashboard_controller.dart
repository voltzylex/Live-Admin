import 'package:live_admin/app/data/api/api_connect.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/modules/home/dashboard/models/dashboard_model.dart';

class DashboardController extends GetxController
    with StateMixin<DashboardModel> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String? currentRoute;
  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
  }

  final RxString currentPage = '/dashboard'.obs;
  // Update the current page
  void changePage(String page) {
    currentPage.value = page;
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

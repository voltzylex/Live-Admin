import 'package:get/get.dart';
import 'package:live_admin/app/controllers/storage_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SC,permanent: true);
  }
}

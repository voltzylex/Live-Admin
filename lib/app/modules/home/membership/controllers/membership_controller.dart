import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:live_admin/app/global_imports.dart';

class MembershipController extends GetxController{

    MembershipController get to => Get.isRegistered<MembershipController>()
      ? Get.find<MembershipController>()
      : Get.put(MembershipController());
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
  // RxList<Movie> movies = <Movie>[].obs;
  final PaginatorController pageController = PaginatorController();
  RxInt currenP = 1.obs;
}